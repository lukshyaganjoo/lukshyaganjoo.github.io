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
    \quad \text{initialize } k \text{ independent hash functions } h_1, h_2, \dots, h_k, \text{ where } h_i : \{0, \dots, n - 1\} \to [0, 1] \\
    \quad \texttt{val}_1 \leftarrow \infty, \texttt{ val}_2 \leftarrow \infty, \dots, \texttt{ val}_k \leftarrow \infty \\
    \quad \text{for } i = 1 \text{ to } n: \\
    \quad \quad x \leftarrow \texttt{stream}[i] \\
    \quad \quad \text{for } j = 1 \text{ to } k: \\
    \quad \quad \quad \texttt{val}_j \leftarrow \min\{\texttt{val}_j, h_j(x)\} \\
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
\Pr[X \leq x] &= 1 - \Pr[X \geq x] && \text{by the complement rule} \\
&= 1 - \Pr[\min\{X_1, X_2, \dots, X_n\} \geq x] && \text{by definition of } X \\
&= 1 - \Pr[X_1 \geq x, X_2 \geq x, \dots, X_n \geq x] \\
&= 1 - \prod_{i = 1}^n \Pr[X_i \geq x] && \text{by independence} \\
&= 1 - \prod_{i = 1}^n (1 - \Pr[X_i \leq x]) && \text{by the complement rule} \\
&= 1 - \prod_{i = 1}^n (1 - x) && \text{since } X_i \sim \text{Uniform}(0, 1) \\
&= 1 - (1 - x)^n
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

The result thus follows by taking the derivative of $$F_X(x)$$ giving us 

$$
f_X(x) = 
\begin{cases}
    0 & \text{if } x \notin [0, 1] \\
    n (1 - x)^{n - 1} & \text{if } x \in [0, 1]
\end{cases} \text{ as desired.}
$$

> **theorem 2**
>
> let $$X_1, X_2, \dots, X_n$$ be independent random variables uniformly distributed in $$[0, 1]$$. let $$Y = \min \limits_{i \in [n]} X_i$$. then $$\mathbb{E}[Y] = \frac{1}{n + 1}$$ and $$\text{Var}(Y) \leq \frac{1}{(n + 1)^2}$$.

**proof** we first compute the expectation, by definition  
<p style = "overflow-x:auto">
$$
\begin{align*}
\mathbb{E}[Y] &= \int_{-\infty}^\infty x f_Y(x) dx = \int_{-\infty}^0 x f_Y(x) dx + \int_0^1 x f_Y(x) dx + \int_1^\infty x f_Y(x) dx &&\text{by definition} \\
&= \int_0^1 x n (1 - x)^{n - 1} dx = n \int_0^1 x (1 - x)^{n - 1} dx && \text{by theorem 1} \\
&= n \int_{0}^{1} (1 - t) t^{n - 1} dt && \text{by the substitution } t = 1 - x \\
&= n \int_{0}^{1} t^{n - 1} - t^n dt = n \left( \frac{t^n}{n} - \frac{t^{n + 1}}{n + 1}\right) \Bigg|_{0}^{1} \\
&= n \left(\frac{1}{n} - \frac{1}{n + 1}\right) = 1 - \frac{n}{n + 1} = \frac{1}{n + 1} 
\end{align*}
$$
</p>
We now turn our attention to computing the variance. We need one more result before we can proceed. 
We compute $$\mathbb{E}[Y^2]$$ and via a similar application of theorem 1 we have that
<p style = "overflow-x:auto">
$$
\begin{align*}
\mathbb{E}[Y^2] &= \int_{-\infty}^\infty x^2 f_Y(x) dx = \int_{-\infty}^0 x^2 f_Y(x) dx + \int_0^1 x^2 f_Y(x) dx + \int_1^\infty x^2 f_Y(x) dx \\
&= \int_0^1 x^2 n (1 - x)^{n - 1} dx = n \int_0^1 x^2 (1 - x)^{n - 1} dx && \text{by theorem 1} \\
&= n \int_{0}^{1} (1 - t)^2 t^{n - 1} dt && \text{by the substitution } t = 1 - x \\
&= n \int_{0}^{1} \bigg(1 - 2t + t^2\bigg) t^{n - 1} dt = n \int_{0}^{1} t^{n - 1} - 2t^n + t^{n + 1} dt \\
&= n \left(\frac{t^n}{n} - \frac{2t^{n + 1}}{n + 1} + \frac{t^{n + 2}}{n + 2}\right)\Bigg|_{0}^{1} \\
&= n \left(\frac{1}{n} - \frac{2}{n + 1} + \frac{1}{n + 2}\right) = n \left(\frac{(n + 1)(n + 2) - 2n(n + 2) + n(n + 1)}{n(n + 1)(n + 2)}\right) \\
&= \frac{n^2 + 3n + 2 - 2n^2 - 4n + n^2 + n}{(n + 1)(n + 2)} = \frac{2}{(n + 1)(n + 2)}
\end{align*}
$$
</p>
We now finally compute the variance, which is given by  
<p style = "overflow-x:auto">
$$
\text{Var}(Y) = \mathbb{E}[Y^2] - \mathbb{E}[Y]^2 = \frac{2}{(n + 1)(n + 2)} - \frac{1}{(n + 1)^2} 
\leq \frac{2}{(n + 1)^2} - \frac{1}{(n + 1)^2} = \frac{1}{(n + 1)^2}
$$
</p>

