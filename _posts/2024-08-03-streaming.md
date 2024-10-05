---
layout: distill
title: the probabilistic method is pretty funny
description: reframing conventionally simple computations with limited models of computation
tags: math
giscus_comments: false
date: 2024-08-03
featured: false

bibliography: 2018-12-22-distill.bib

toc:
  - name: introduction
  - name: the problem 
  - name: a surprisingly simple solution
  - name: why is an average of minimums necessary?
  - subsections: 
    - name: a potentially flawed solution
  - name: the proof
  - name: theorems and references
---

## introduction
the object of consideration for today might be slightly different than what you're used to. the computational 
model we will be using for this proof is the streaming model. in this model, we are given a sequence of elements 
in a "stream" and we have to process them one by one. given that the number of elements in our data stream could be significantly larger than the amount of memory we have, we aren't allowed to store the entire stream in memory, and are instead allowed a small amount of space to store the information we deem relevant. the question now becomes; what functions of the input stream can we compute with what amount of time and model? while we will be focusing on space; similar considerations and conclusions can be made for time. under normal circumstances, the study of such a model would be motivated by introducing the notion of **moments** where you consider the stream as a high-dimensional vector and may want to compute the $$k$$-th moment of the vector. while this is useful, the motivating route we take is slightly different. 

## the problem 
> consider the problem of finding the number of distinct elements in a stream of elements. while this is a trivial problem in the standard computational model since we can simply store the elements and count the number of distinct elements, the streaming model makes this problem significantly more challenging.  


> **theorem**
>
> we present a streaming algorithm to estimate the number of distinct elements in the
> sequence with multiplicative error $$1 \pm \epsilon$$ for some $$\epsilon \in (0, 1)$$. for the algorithm, we assume access to $$k$$ independent hash functions as described above. the number of hash functions required depends on the desired precision, i.e. $$k \leq \mathcal{O}(1/\epsilon^2)$$ is sufficient to achieve the desired error guarantee. 

> **definition**
>
> a **hash function** is a function $$h : A \to B$$ where $$A = \{a \in \{0, 1\}^j \mid j \in \mathbb{N}\}$$ is the set of all bit sequences of aritrary length and $$B = \{0, 1\}^k$$ is the set of all bit sequences of a specific length $$k \in \mathbb{N}$$. Note that it is not important to understand deeply the definition of a hash function, rather simply that with the appropriate independence assumptions, it essentially behaves like a uniform random variable.

## a surprisingly simple solution 
<p style = "overflow-x:auto">
$$
\begin{array}{l}
    \textbf{function} \; \texttt{estimateDistinct}(\text{stream},  k): \\
    \quad \text{initialize } k \text{ independent hash functions } h_1, h_2, \dots, h_k, \text{ where } h_i : \{0, \dots, n - 1\} \to [0, 1] \\
    \quad \texttt{val}_1 \leftarrow \infty, \texttt{ val}_2 \leftarrow \infty, \dots, \texttt{ val}_k \leftarrow \infty \\
    \quad \text{for } i = 1 \text{ to } n: \\
    \quad \quad x \leftarrow \texttt{stream}[i] \\
    \quad \quad \text{for } j = 1 \text{ to } k: \\
    \quad \quad \quad \texttt{val}_j \leftarrow \min\{\texttt{val}_j, h_j(x)\} \\
    \quad Z \leftarrow \frac{1}{k} \sum \limits_{i = 1}^k \texttt{val}_i \\
    \quad \text{return } \bigg\lfloor \frac{1}{Z} - 1 \bigg\rfloor \\
\end{array}
$$
</p>
what the above algorithm is essentially doing is hashing each element in the stream $$k$$ times and keeping track of the minimum hash value for each element. it is then taking the average of these minimum hash values and returning the appropriate estimate on the last line of the algorithm. 

## why is an average of minimums necessary?
in order to answer this question, we consider the following modification to the algorithm. 

### a potentially flawed solution 
<p style = "overflow-x:auto">
$$
\begin{array}{l}
  \textbf{function} \; \texttt{incorrectEstimateDistinct}(\text{stream},  k): \\
  \quad \text{initialize a} \text{ hash function } h \text{ which hashes elements to } [0, 1] \\
  \quad \texttt{val} \leftarrow \infty
  \quad \text{for } i = 1 \text{ to } n: \\
  \quad \quad x \leftarrow \texttt{stream}[i] \\
  \quad \quad \quad \texttt{val}_i \leftarrow \min\{\texttt{val}_i, h(x)\} \\
  \quad Z \leftarrow \min \limits_{i \in [k]} \texttt{val}_i \\
  \quad \text{return } \bigg\lfloor \frac{1}{Z} - 1 \bigg\rfloor \\
\end{array}
$$
</p>
it turns out that the above algorithm produces the correct solution on average! (in fact we use this very fact in the proof of the main theorem). 

> **lemma 1**
>
> <p style = "overflow-x:auto">
> $$\begin{align*}
> \text{number of distinct elements in the data stream} = \frac{1}{\mathbb{E}[Z]} - 1\end{align*}
> $$
> </p>

**proof**
Indeed from Theorem 2, we have that $$\mathbb{E}[Z] = \frac{1}{k + 1}$$ and a matter of simple algebra yields that 
<p style = "overflow-x:auto">
$$
\begin{align*}
\mathbb{E}[Z] &= \frac{1}{k + 1} \implies \frac{1}{\mathbb{E}[Z]} = k + 1 \\
\end{align*}
$$ thereby ensuring that we return the correct estimate on average. 
</p>

So what goes wrong in the above algorithm. The issue is that the variance of the estimator is too high. In fact, 
defining $$Y = \min (h(x_1), h(x_2), \dots, h(x_n))$$ as above in the algorithm; following similar steps to the variance computation in Theorem 2 yields 
<p style = "overflow-x:auto">
$$
\begin{align*}
\text{Var}(Y) &= \frac{k}{(k + 1)^2 (k + 2)} \approx \frac{1}{(k + 1)^2}
\end{align*}
$$
</p> and therefore by Chebyshev's inequality, the probability that the estimate is off by more than a factor of $$1 \pm \epsilon$$ is
$$\mathcal{O}(1/\epsilon^2)$$.

## the proof 

## theorems and references 

> **theorem 1**
>
> Let $$X_1, X_2, \dots, X_n$$ be independent random variables uniformly distributed in $$[0, 1]$$ and let $$X := \min\{X_1, X_2, \dots, X_n\}$$. Then 
>
> <p style = "overflow-x:auto">
> $$
> f_X(x) = \begin{cases}0 & \text{if } x \notin [0, 1] \\ n (1 - x)^{n - 1} & \text{if } x \in [0, 1]\end{cases}
> $$
> </p>

**proof** 
We proceed as usual; by first computing the CDF, i.e. $$F_X(x) = \Pr[X \leq x]$$. We have that 
<p style = "overflow-x:auto">
$$
\begin{align*}
\Pr[X \leq x] &= 1 - \Pr[X \geq x] = 1 - \Pr[\min\{X_1, X_2, \dots, X_n\} \geq x] \\
&= 1 - \Pr[X_1 \geq x, X_2 \geq x, \dots, X_n \geq x] = 1 - \prod_{i = 1}^n \Pr[X_i \geq x] \\
&= 1 - \prod_{i = 1}^n (1 - x) = 1 - (1 - x)^n
\end{align*}
$$
</p>
Therefore we have that 

$$
F_X(x) = 
\begin{cases}
    0 & \text{if } x < 0 \\
    1 - (1 - x)^n & \text{if } x \in [0, 1] \\
    1 & \text{if } x > 1
\end{cases}
$$

The result thus follows by taking the derivative of $$F_X(x)$$.

> **theorem 2**
>
> let $$X_1, X_2, \dots, X_n$$ be independent random variables uniformly distributed in $$[0, 1]$$. let $$Y = \min \limits_{i \in [n]} X_i$$. then $$\mathbb{E}[Y] = \frac{1}{n + 1}$$ and $$\text{Var}(Y) \leq \frac{1}{(n + 1)^2}$$.

**proof** we first compute the expectation, by definition  
<p style = "overflow-x:auto">
$$
\begin{align*}
\mathbb{E}[Y] &= \int_0^1 x n (1 - x)^{n - 1} dx = n \int_0^1 x (1 - x)^{n - 1} dx = \frac{1}{n + 1} && \text{by theorem 1}
\end{align*}
$$
</p>
We now turn our attention to computing the variance. We need one more result before we can proceed. 
We compute $$\mathbb{E}[Y^2]$$ and via a similar application of theorem 1 we have that
<p style = "overflow-x:auto">
$$
\begin{align*}
\mathbb{E}[Y^2] &= \int_0^1 x^2 n (1 - x)^{n - 1} dx && \text{by theorem 1}  \\
&= n \int_0^1 x^2 (1 - x)^{n - 1} dx = \frac{2}{(n + 1)(n + 2)}
\end{align*}
$$
</p>
We now finally compute the variance, which is given by  
<p style = "overflow-x:auto">
$$
\begin{align*}
\text{Var}(Y) &= \mathbb{E}[Y^2] - \mathbb{E}[Y]^2 = \frac{2}{(n + 1)(n + 2)} - \frac{1}{(n + 1)^2} \\
&\leq \frac{2}{(n + 1)^2} - \frac{1}{(n + 1)^2} = \frac{1}{(n + 1)^2}
\end{align*}
$$
</p>

