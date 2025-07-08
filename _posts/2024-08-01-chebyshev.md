---
layout: distill
title: chebyshev ruins convocations
description: i spent far too much time looking at normal distributions for this one
tags: math
giscus_comments: false
date: 2023-06-15
featured: false

bibliography: 2018-12-22-distill.bib

toc:
  - name: some background
  - name: the actual problem
  - name: theorems and references
---

## some background

i was enrolled in this cs course titled "toolkit for modern algorithms" spring of this year. that class, more than anything else felt like the birth child of a standard algorithms class and techniques you'd learn in machine learning. i have several things i could say about that class, but that's not what the point of this post is. similar to several other classes in the cs department here, we had weekly assignments. in the penultimate week of the class, there was an extra credit problem assigned that i spent a lot of time pondering about. providing some more context for why the title of this proof/blogpost is what it is, i was not able to figure out the problem in time. to make things more agonizing, i flew to maryland the same week for my brother's convocation! while it was great seeing my brother graduate, it would have been significantly better had i not spent as much time as i did thinking about how a simple inequality lived in my head rent-free.

## the actual problem

now that i'm done rambling about the context, the problem in and of itself is actually quite interesting, and i think there's something about the somewhat unusual combination techniques used that is useful to know. the problem is as follows:

> For any $$n$$ real numbers $$a_1, a_2, \dots a_n$$ satisfying $$a_1^2 + a_2^2 + \dots + a_n^2 = 1$$, if $$\sigma_1 \sigma_2, \dots, \sigma_n \in \{-1, 1\}$$ are i.i.d uniform random signs, then
>
> <p style = "overflow-x:auto">
> $$ \Pr \left[\left \vert \sum_{i = 1}^{n} a_i \sigma_i\right \vert  \leq 1\right] \geq \frac{1}{32}
$$
> </p>

## the proof
we split the proof into two cases based on the size of coefficients

> **Case 1: a big coefficient**
>
> For simplicity, we may sort so that $$\vert  a_1 \vert  \geq \vert  a_2 \vert  \geq \dots \vert  a_n \vert $$.
>
> Additionally we define the random variable $$X = \sum \limits_{i = 1}^{n} a_i \sigma_i$$. Based on the assumption of the case, we assume without loss of generality that $$\vert  a_1 \vert  \geq 1/\sqrt{2}$$ and apply Chebyshev's inequality on $$X_1 = X - a_1 \sigma_1$$ to conclude that
>
> <p style = "overflow-x:auto">
> $$\Pr[\vert X \vert  \leq 1] \geq \frac{1}{4}$$
> </p>


**proof:** We first compute out the expectation of $$X_1$$ where we have that

<p style = "overflow-x:auto">
$$

\begin{align*}
\mathbb{E}[X_1] &= \mathbb{E}\left[X - a_1 \sigma_1 \right] &&\text{by definition of } X_1 \\\
&= \mathbb{E}\left[\sum_{i = 1}^{n} a_i \sigma_i - a_1 \sigma_1 \right] &&\text{by definition of } X \\\
&= \mathbb{E}\left[\sum_{i = 2}^{n} a_i \sigma_i\right] \\\
&= \sum_{i = 2}^{n} a_i \mathbb{E}[\sigma_i] = 0 &&\text{linearity of expectation and Theorem 1}
\end{align*}

$$
</p>

Now we define the event $$\mathcal{A}$$ as the event that $$X$$ and $$\sigma_1 a_1$$ have the same sign. Note that since $$\sigma_1$$ is a uniformly random sign, $$\Pr[\mathcal{A}] = 1/2$$. We therefore have that

<p style = "overflow-x:auto">
$$

\begin{align*}
\Pr[\vert X\vert \leq 1] &= \Pr[\vert X_1 + a_1 \sigma_1\vert \leq 1] \\\
&= \Pr[\vert X_1 + a_1 \sigma_1\vert \leq 1 \mid \mathcal{A}] \cdot \Pr[\mathcal{A}] \\\
&+ \Pr[\vert X_1 + a_1 \sigma_1\vert \leq 1 \mid \mathcal{A}^c] \cdot \Pr[\mathcal{A}^c] \\\
&\geq \Pr[\vert X_1 + a_1 \sigma_1\vert \leq 1 \mid \mathcal{A}] \cdot \Pr[\mathcal{A}] \\\
&= \frac{1}{2} \cdot \Pr[\vert X_1 + a_1 \sigma_1\vert \leq 1 \mid \mathcal{A}] \\\
&\geq \frac{1}{2} \cdot \Pr[\vert X_1\vert - \vert a_1 \vert \leq 1] = \frac{1}{2} \cdot \Pr[\vert X_1\vert \leq 1 + \vert a_1 \vert ] &&\text{triangle inequality} \\\
&= \frac{1}{2} \left(1 - \Pr[\vert X_1\vert \geq 1 + \vert a_1 \vert ]\right) \geq \frac{1}{2} \left(1 - \frac{\text{Var}(X_1)}{(1 + \vert a_1 \vert )^2}\right) &&\text{Chebyshev's and Theorem 2} \\\
&\geq 1/4
\end{align*}

$$
</p>

> **Case 2: all small coefficients**
>
> We now assume that $$1/\sqrt{2} > \vert  a_1 \vert  \geq \vert  a_2 \vert  \geq \dots \geq \vert  a_n \vert $$.
>
> The really clever thing we can do is to split the sum $$X = Y + Z$$ into two pieces and apply Chebyshev's inequality separately to $$Y$$ and $$Z$$ to conclude that
>
> <p style = "overflow-x:auto">
> $$\Pr[\vert X\vert  \leq 1] \geq \frac{1}{32}$$
> </p>

**proof:** We define the random variables $$Y, Z$$ as follows

<p style = "overflow-x:auto">
$$
Y = \sum_{i = 1}^{n/2} a_{2i - 1} \sigma_{2i - 1} \quad \text{and} \quad Z = \sum_{i = 1}^{n/2} a_{2i} \sigma_{2i}
$$
</p>

We have that

<p style = "overflow-x:auto">
$$
Y + Z = \sum_{i = 1}^{n/2} a_{2i - 1} \sigma_{2i - 1} + \sum_{i = 1}^{n/2} a_{2i} \sigma_{2i} = \sum_{i = 1}^{n} a_i \sigma_i = X
$$
</p>

This necessarily implies as a consequence of the linearity of variance for independent random variables that

<p style = "overflow-x:auto">
$$
\begin{align}
1 = \text{Var}\left(\sum_{i = 1}^{n} a_i \sigma_i\right)= \text{Var}(X) = \text{Var}(Y) + \text{Var}(Z)
\end{align}
$$
</p>

As a consequence of theorem 4 and $$(1)$$, we have that

<p style = "overflow-x:auto">
$$
\text{Var}(Y) + \text{Var}(Z) = 1 \quad \text{and} \quad \text{Var}(Y) - \text{Var}(Z) < 1/2
$$
</p>

Putting two and two together, we can finally ascertain that

<p style = "overflow-x:auto">
$$
1/4 \leq \text{Var}(Z) \leq \text{Var}(Y) \leq 3/4
$$
</p>

We now define the event $$\mathcal{S}$$ to be the event that $$Y$$ and $$Z$$ have different signs. Note that since $$\sigma_1, \sigma_2, \dots, \sigma_n$$ are uniformly random signs, $$\Pr[\mathcal{S}] = 1/2$$. We therefore have that

<p style = "overflow-x:auto">
$$
\begin{align*}
\Pr[\vert X \vert \leq 1] &= \Pr[\vert Y + Z \vert \leq 1] \\\
 &= \Pr[\vert Y + Z \vert \leq 1 \mid \mathcal{S}] \cdot \Pr[\mathcal{S}] \\\
 &+ \Pr[\vert Y + Z \vert \leq 1 \mid \mathcal{S}^c] \cdot \Pr[\mathcal{S}^c] &&\text{law of total probability} \\\
 &\geq \Pr[\vert Y + Z \vert \leq 1 \mid \mathcal{S}] \cdot \Pr[\mathcal{S}] \\\
 &= \frac{1}{2} \cdot \Pr[\vert Y + Z \vert \leq 1 \mid \mathcal{S}] &&\text{since } \Pr[\mathcal{S}] = 1/2 \\\
 &= \frac{1}{2} \cdot \Pr[\big\vert \vert Y \vert - \vert Z \vert \big\vert \leq \vert Y + Z \vert \leq 1] &&\text{reverse triangle inequality} \\\
&\geq \frac{1}{2} \cdot \Pr[\big\vert \vert Y \vert - \vert Z \vert \big\vert \leq 1] \\\
 &\geq \frac{1}{2} \cdot \Pr[\vert Y \vert \leq 1 \cap \vert Z \vert \leq 1] \\\
 &= \frac{1}{2} \cdot \Pr[\vert Y \vert \leq 1] \cdot \Pr[\vert Z \vert \leq 1] &&\text{since } Y, Z \text{ are independent} \\\
 &\geq \frac{1}{2} \cdot \big(1 - \Pr[\vert Y \vert \geq 1]\big) \cdot \big(1 - \Pr[\vert Z \vert \geq 1]\big) &&\text{complementation} \\\
 &= \frac{1}{2} \cdot \big(1 - \Pr[\vert Y - \mathbb{E}[Y]\vert \geq 1]\big) \cdot \\\
 &\big(1 - \Pr[\vert Z - \mathbb{E}[Z]\vert \geq 1]\big) &&\text{Theorem 3} \\\
 &\geq \frac{1}{2} \cdot \big(1 - \frac{\text{Var}(Y)}{1}\big) \cdot \big(1 - \frac{\text{Var}(Z)}{1}\big) &&\text{Chebyshev's inequality} \\\
 &= \frac{1}{2} \cdot \big(1 - \text{Var}(Y)\big) \cdot \big(1 - \text{Var}(Z)\big) \\\
 &\geq \frac{1}{2} \frac{1}{4} \frac{1}{4} = \frac{1}{32}
\end{align*}
$$
</p>

## theorems and references

> **theorem 1**
>
> For uniformly random signs $$\sigma_1, \sigma_2 \dots, \sigma_n \in \{-1, 1\}$$, $$\text{Var}(\sigma_i) = 1$$ for all $$i \in [n]$$ and $$\mathbb{E}[\sigma_i] = 0$$.

**proof:**
We first compute the expectation of $$\sigma_i$$ which by definition comes out to be

<p style = "overflow-x:auto">
$$
    \mathbb{E}[\sigma_i] = \sum_{x \in \Omega_X} x \cdot \Pr[X = x] = 1/2 - 1/2 = 0
$$
</p>

The second step in computing the variance of $$\sigma_i$$ is computing out $$\mathbb{E}
[\sigma_i^{2}]$$ which by definition is simply

<p style = "overflow-x:auto">
$$
    \mathbb{E}[\sigma_i^2] = \sum_{x \in \Omega_X} x^2 \cdot \Pr[X = x] = 1/2 + 1/2 = 1
$$
</p>

Therefore we have from the definition of variance that

<p style = "overflow-x:auto">
$$
    \text{Var}(\sigma_i) = \mathbb{E}[\sigma_i^2] - \mathbb{E}[\sigma_i]^2 = 1 - 0 = 1
$$
</p>

> **theorem 2**
>
> If $$X = \sum \limits_{i = 1}^{n} a_i \sigma_i$$ for uniformly random signs $$\sigma_1, \sigma_2, \dots, \sigma_n \in \{-1, 1\}$$, where $$\vert  a_1 \vert  \geq 1/\sqrt{2}$$ and $$X_1 = X - a_1 \sigma_1$$, then we can establish an upper bound on the variance, more concretely, $$\text{Var}(X_1) \leq 1/2$$. Note here that in this setting we also have that $$a_1^2 + \dots + a_n^2 = 1$$.

**proof:**
Note that the setting we're interested in is when the $$\sigma_i$$'s are independently and identically distributed which makes our life a lot easier. We therefore have that

<p style = "overflow-x:auto">
$$
\begin{align*}
\text{Var}(X_1) &= \text{Var}\bigg(X - a_1 \sigma_1\bigg) &&\text{by definition of } X \\
&= \text{Var}\left(\sum_{i = 1}^{n} a_i \sigma_i - a_1 \sigma_1\right) &&\text{by definition of } X_1 \\
&= \text{Var}\left(\sum_{i = 2}^{n} a*i \sigma_i\right) &&\text{simplifying} \\
&= \sum_{i = 2}^{n} \text{Var}(a_i \sigma_i) = \sum_{i = 2}^{n} a_i^2 \text{Var}(\sigma_i) &&\text{independence} \\
&= \sum_{i = 2}^{n} a_i^2 = \sum_{i = 1}^{n} a_i^2 - a_1^2 &&\text{Theorem 1} \\
&= 1 - a_{1}^2 = 1 - \vert a_{1}\vert ^{2} &&\text{since } a_1 \in \mathbb{R}
\end{align*}
$$
</p>

The rest of our argument follows from a simple bounding argument on $$\vert  a_1 \vert $$ therefore giving us

<p style = "overflow-x:auto">
$$
\vert a_1 \vert \geq 1/\sqrt{2} \implies \vert a_1 \vert ^2 \geq 1/2 \implies - \vert a_1 \vert ^2 \leq 1/2 \implies
\text{Var}(X_1) = 1 - \vert a_1 \vert ^2 \leq 1/2
$$
</p>

> **theorem 3**
>
> If we define the random variable $$Y = \sum \limits_{i = 1}^{n/2} a_{2i - 1} \sigma_{2i - 1}$$ and $$Z = \sum \limits_{i = 1}^{n/2} a_{2i} \sigma_{2i}$$, then we have that $$\mathbb{E}[Y] = 0$$ and $$\mathbb{E}[Z] = 0$$.


**proof:** We have as a consequence of Theorem 1 and linearity of expectation that

<p style = "overflow-x:auto">
$$
\mathbb{E}[Y] = \mathbb{E}\left[\sum_{i = 1}^{n/2} a_{2i - 1} \sigma_{2i - 1}\right] = \sum_{i = 1}^{n/2} a_{2i - 1} \mathbb{E}[\sigma_{2i - 1}] = 0
$$
</p>

Similarly, we have that

<p style = "overflow-x:auto">
$$
\mathbb{E}[Z] = \mathbb{E}\left[\sum_{i = 1}^{n/2} a_{2i} \sigma_{2i}\right] = \sum_{i = 1}^{n/2} a_{2i} \mathbb{E}[\sigma_{2i}] = 0
$$
</p>

> **theorem 4**
>
> Based on the above definitions of $$Y$$ and $$Z$$, we have that
> <p style = "overflow-x:auto">
> $$\text{Var}(Y) - \text{Var}(Z) < 1/2$$
> </p>

**proof:** We have that

<p style = "overflow-x:auto">
$$
\begin{align*}
\text{Var}(Y) - \text{Var}(Z) &=
\text{Var}\left(\sum_{i = 1}^{n/2} a_{2i - 1} \sigma_{2i - 1}\right) - \text{Var}\left(\sum_{i = 1}^{n/2} a_{2i} \sigma_{2i}\right) \\
 &= \sum_{i = 1}^{n/2} a_{2i - 1}^2 \text{Var}(\sigma_{2i - 1}) - \sum_{i = 1}^{n/2} a_{2i}^2 \text{Var}(\sigma_{2i}) \\
 &= \sum_{i = 1}^{n/2} a_{2i - 1}^2 - \sum_{i = 1}^{n/2} a_{2i}^2 = \sum_{i = 1}^{n/2} (a_{2i - 1}^2 - a_{2i}^2) &&\text{Theorem 1} \\
 &= a_1^2 + a_3^2 + \dots + a_{n - 1}^2 - a_2^2 - a_4^2 - \dots - a_n^2 \
 &= a_1^2 + (a_3^2 - a_2^2) + (a_5^2 - a_4^2) + \dots + (a_{n - 1}^2 - a_n^2) \\
 &= a_1^2 + \sum_{i = 2}^{n/2} \underbrace{(a_{2i - 1}^2 - a_{2i - 2}^2)}_{< 0} < a_1^2 < 1/2
\end{align*}
$$
</p>
