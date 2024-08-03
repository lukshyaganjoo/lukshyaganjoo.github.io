---
layout: distill
title: perfect matchings and how **most** graphs are connected
description: two words: probabilistic method
tags: math
giscus_comments: false
date: 2024-08-01
featured: false

bibliography: 2018-12-22-distill.bib

toc:
  - name: introduction and some background
  - name: the problem itself
  - name: the proof
  - subsections: 
    - name: identifying the problem-child
    - name: the main result
---

## introduction and some background
i genuinely think that there isn't a single person who wouldn't like graph theory if given the chance. if you aren't familiar with the concept, don't worry; just trust me on this one. my first proper exposure to graph theory funnily enough was in a randomized algorithms course i took fairly recently. i have a lot to say about how wicked the probabilistic method is but let's save that for another day. the moral of this story and maybe the purpose of this somewhat convoluted introduction is that "combining certain kinds of networks" (whatever that means) has interesting connections to whether a person who were stuck in said network can get from any point to any other point. 

given that the above discussion was quite vague, it may help to see some concrete notions of the tools we'll be using in the problem. 

> **definitions** 
> 
> - a graph $$\mathcal{G}$$ is a collection of vertices $$V$$ and edges $$E$$ such that each edge connects two vertices, where notationally we write $$\mathcal{G} = (V, E)$$. a **multi-graph** is a graph that allows for 
> multiple edges between the same pair of vertices.
> 
> - a graph is said to be **connected** if there exists a path between any two vertices in the graph, i.e. 
> for any two vertices $$u, v \in V$$, there exists a sequence of vertices $$u = v_0, v_1, \ldots, v_k = v$$ such that $$(v_i, v_{i+1}) \in E$$ and $$v_i \in v$$ for all $$i = 0, 1, \ldots, k-1$$.
>
> - a **matching** in a graph $$\mathcal{G}$$ is a set of edges $$M \subseteq E$$ such that no two edges in $$M$$ share a vertex. a matching is said to be **perfect** if every vertex in $$V$$ is incident to exactly one edge in $$M$$.

## the problem itself
> let $$n$$ be an even integer and let $$\mathcal{G}_k$$ be the multi-graph on $$n$$ vertices formed by taking the 
> union of $$k$$ (possibly overlapping) perfect matchings, which are chosen uniformly at random from the set of all perfect matchings on $$n$$ vertices. show that for $$k \geq 3$$, the probability that $$\mathcal{G}_k$$ is **connected** tends to $$1$$ as $$n \to \infty$$.

## the proof 
it may not be immediately clear how to proceed with this problem, in fact it may not even be readily apparent why 
the hypothesis of having $$k \geq 3$$ is necessary. the necessity of this condition is stated below 

### identifying the problem-child 

> **theorem**
>
> for $$k = 2$$, the probability that $$\mathcal{G}_k$$ is connected tends to $$0$$ as $$n \to \infty$$.

When $$k = 2$$, we can see that the multi-graph formed by the union of two perfect matchings results in the degree of every vertex being 2 (since each vertex in a perfect matching has degree 1). Following this reasoning, the graph is a union of disjoint cycles, and it is equivalent to say that the graph is connected if and only if there exists a **Hamiltonian cycle**.  

> **definition**
>
> a **cycle** in a graph $$\mathcal{G}$$ is a sequence of vertices $$v_1, v_2, \ldots, v_k$$ such that $$(v_i, v_{i+1}) \in E$$ for all $$i = 1, 2, \ldots, k - 1$$ and $$(v_k, v_1) \in E$$. a cycle is said to be **Hamiltonian** if it visits every vertex exactly once.

We now fix the first perfect matching. We proceed by computing the probability that the second 
perfect matching does not close a shorter cycle. We start with the first vertex $$v_1$$ and the endpoint of the 
first edge $$(v_1, u_1)$$. $$u_1$$ must be connected to some other vertex $$v_2$$ in the second perfect matching, in order to not close a cycle, let's call this vertex $$v_2$$. Since there are $$n$$ vertices, there are $$n - 2$$ ways to construct an edge from $$v_2$$ to another vertex. Therefore the probability is given by $$(n - 2)/(n - 1)$$ (since we don't consider self-loops) Now $$v_2$$ is part of some other edge $$(v_2, u_2)$$. $$u_2$$ must be connected to some other vertex $$v_3$$, and not any of the previous vertices. This gives us $$(n - 4)/(n - 3)$$ choices where the denominator is $$n - 3$$ since we don't consider edges going from $$u_2$$ to itself, $$v_1$$, or $$v_2$$. We continue this process until we reach the last vertex $$v_{n - 1}$$, giving us  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr[\mathcal{G}_k \text{ is connected}] = \frac{n - 2}{n - 1} \cdot \frac{n - 4}{n - 3} \cdots \frac{2}{1} = \frac{(n - 2)!!}{(n - 1)!!}
\end{align*}
$$
</p>
Since $$n = 2t$$ (there are an even number of vertices in a perfect matching), we have  
<p style = "overflow-x:auto">
$$
\begin{align*}
    \frac{(n - 2)!!}{(n - 1)!!} &= \frac{(2t - 2)!!}{(2t - 1)!!} = \frac{(2t - 2) \cdot (2t - 4) \cdots 2}{(2t - 1) \cdot (2t - 3) \cdots 1} \\
    &= \frac{2^{t - 1} \cdot (t - 1)!}{(2t - 1) \cdot (2t - 3) \cdots 1} = \frac{2^{t - 1} \cdot (t - 1)!}{(2t - 1)!!} \\
    &= \frac{2^{t - 1} (t - 1)!}{\frac{(2t)!}{(2t)!!}} = \frac{2^{t - 1} (2t)!! (t - 1)!}{(2t)!} \\
    &= \frac{2^{t - 1} (t - 1)!}{(2t)!} (2t)(2t - 2) \cdots 2 = \frac{2^{t - 1} (t - 1)!}{(2t)!} \cdot 2^t t! \\
    &= 2^{2t - 1} \cdot \frac{(t - 1)!}{(2t)!} \cdot k! \\
    &\approx 2^{2t - 1} \cdot \frac{\left(\frac{t - 1}{e}\right)^{t - 1}}{\left(\frac{2t}{e}\right)^{2t}} \cdot \frac{t^{t}}{e^{t}} &&\text{ Stirling's approximation} \\
    &= 2^{2t - 1} \cdot \frac{(t - 1)^{t - 1} / e^{t - 1}}{(2t)^{2t} / e^{2t}} \cdot \frac{t^{t}}{e^{t}} \\
    &= 2^{2t - 1} \cdot \frac{(t - 1)^{t - 1}}{e^{t - 1}} \cdot \frac{e^{2t}}{(2t)^{2t}} \cdot \frac{t^{t}}{e^{t}} = 2^{2t - 1} e \cdot \frac{(t - 1)^{t - 1}}{2^{2t} t^{2t}} \cdot t^{t} \\
    &= \frac{e}{2} \cdot \frac{(t - 1)^{t - 1}}{t^{2t}} \cdot t^{t} = \frac{e}{2} \cdot \frac{(t - 1)^{t - 1}}{t^t} \\
    &= \frac{e}{2} \cdot \frac{\left(\frac{t - 1}{t}\right)^{t - 1}}{t} = \frac{e}{2} \cdot \frac{\left(1 - \frac{1}{t}\right)^{t - 1}}{t} \\
    &\approx e \cdot \frac{e^{-1/t (t - 1)}}{2k} = e \cdot \frac{e^{1/t - 1}}{2t} \\
    &= e/n \cdot e^{1/t - 1} = e^{1/t} / n && \text{since } n = 2t
\end{align*}
$$
</p>
It is clear that  
<p style = "overflow-x:auto">
$$
\begin{align*}
    e^{1/t} / n = e^{2/n} / n \to 0 \text{ as } n \to \infty
\end{align*}
$$
</p>

Another way to see this is to note that for $$n$$ large enough, since $$n \geq 2$$,  

<p style = "overflow-x:auto">
$$
\begin{align*}
    e^{2/n} / n \leq e^{2/2} / n = e / n \to 0 \text{ as } n \to \infty
\end{align*}
$$
</p>
The claim thus follows since,  
<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr[\mathcal{G}_k \text{ is connected}] = \frac{(n - 2)!!}{(n - 1)!!} = \frac{e^{1/t}}{n} \to 0 \text{ as } n \to \infty
\end{align*}
$$
</p>

### the main result
now that we have established the necessity of the condition $$k \geq 3$$, we can proceed with the main result. specifically we show that the claim is true for $$k = 3$$ and our method immediately generalizes to any $$k > 3$$.

Observe that a graph is said to be connected if and only if every cut contains an edge. We define $$\mathcal{G}_k = (V, E)$$ to be a multi-graph with $$2n$$ vertices (since perfect matchings only exist on graphs with an even number of vertices). Let $$\Omega$$ be the set of all possible cuts in $$\mathcal{G}_k$$. We then have  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr\bigg[\mathcal{G}_k \text{ is connected}\bigg] &= \Pr\bigg[\bigcap_{\omega \in \Omega} \omega \text{ contains an edge}\bigg]
\end{align*} 
$$
</p>
We want to show that this probability approaches 1 for $$n \to \infty$$. Note that this is equivalent to saying  
<p style = "overflow-x:auto">
$$
    \Pr\bigg[G_k \text{ is disconnected}\bigg] \to 0 \text{ as } n \to \infty
$$ 
</p> following from a simple application of complementation. 

Using De Morgan's Law and simplifying slightly, we have  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr\bigg[\mathcal{G}_k \text{ is disconnected}\bigg] &= \Pr\bigg[\left(\bigcap_{\omega \in \Omega} \omega \text{ contains an edge}\right)^c\bigg] \\
    &= \Pr\bigg[\bigcup_{\omega \in \Omega} \left(\omega \text{ contains an edge}\right)^c\bigg] && \text{De Morgan's Law} \\
    &= \Pr\bigg[\bigcup_{\omega \in \Omega} \omega \text{ contains no edges}\bigg] \\
    &\leq \sum_{\omega \in \Omega} \Pr\bigg[\omega \text{ contains no edges}\bigg] && \text{Union Bound}
\end{align*}
$$  
</p>

We are now interested in the probability that a cut doesn't have an edge. Therefore we fix some cut $$C = (S, V \setminus S)$$ such that $$\lvert S \rvert = l$$ and $$\lvert V \setminus S \rvert = 2n - l$$. We're interested in computing the probability that there is no edge between $$S$$ and $$V \setminus S$$, i.e. $$\Pr[\lvert E(S, V \setminus S) \rvert = 0]$$. We make the observation that if $$\lvert E(S, V \setminus S) \rvert = 0$$, then the perfect matchings restricted to $$S$$ are also a perfect matching. Note that since we have perfect matchings, any cut of odd size is assured to have size greater than zero. Thus, it suffices to consider the cases where the cut $$C$$ divides graph into a subsets of size $$2i, 2n - 2i$$ where $$1 \leq i \leq n - 1$$, allowing us to conclude that $$l = 2i$$. Note that the number of perfect matchings on $$2i$$ vertices is given by  

<p style = "overflow-x:auto">
$$
    \# \text{ of perfect matchings on } 2i \text{ vertices} = \frac{(2i)!}{2^i i!} = (2i - 1)!!
$$  
</p>

where $$!!$$ indicates the double factorial. This number can be found via picking a vertex $$v_1$$, noting that there are $$2i - 1$$ choices for the vertex $$v_2$$ as its endpoint (since it cannot be itself), then find another vertex $$v_3$$, observing that it has $$2i - 3$$ vertices to choose from (cannot be any of the previous 2 or itself) and so on. Therefore, all this implies that finding the number of perfect matchings on $$n$$ vertices with no edges is equivalent to finding a perfect matching on $$S$$ and a perfect matching on $$V \setminus S$$ where $$\lvert S \rvert = 2i, \lvert V \setminus S \rvert = 2n - 2i$$.

We partition over the size of all possible cuts. Considering the cuts of size $$2i$$ and $$2n - 2i$$ where $$i \in \{1, \dots, n - 1\}$$ and then noting that for a single perfect matching, the probability that a cut of size $$2i$$ doesn't have an edge is given by  

<p style = "overflow-x:auto">
$$
    \Pr[\text{cut of size } 2i \text{ has no edges for a perfect matching}] = \frac{\frac{(2i)!}{2^i i!} \cdot \frac{(2n - 2i)!}{2^{n - i} (n - i)!}}{\frac{(2n)!}{2^n n!}}
$$  
</p>

The probability that all 3 perfect matchings have no edges crossing this cut is given by  

<p style = "overflow-x:auto">
$$
    \Pr[\text{cut of size } 2i \text{ has no edges for 3 perfect matchings}] = \left(\frac{\frac{(2i)!}{2^i i!} \cdot \frac{(2n - 2i)!}{2^{n - i} (n - i)!}}{\frac{(2n)!}{2^n n!}}\right)^3
$$
</p>

since the matchings are drawn uniformly at random. 

We also note that there are $$\binom{2n}{2i}$$ ways to choose the vertices for the cut. Therefore trudging through all the algebra in the sum we had earlier gives us 

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr\bigg[G_k \text{ is disconnected}\bigg] &\leq \sum_{i = 1}^{n - 1} \Pr[\text{cut of size } 2i \text{ has no edges}] \\
    &= \sum_{i = 1}^{n - 1} \binom{2n}{2i} \cdot \left(\frac{\frac{(2i)!}{2^i i!} \cdot \frac{(2n - 2i)!}{2^{n - i} (n - i)!}}{\frac{(2n)!}{2^n n!}}\right)^3 \\
    &= \sum_{i = 1}^{n - 1} \binom{2n}{2i} \left(\frac{\frac{(2i)! (2n - 2i)}{i! (n - i)!}}{\frac{(2n)!}{n!}}\right)^3 \\
    &= \sum_{i = 1}^{n - 1} \binom{2n}{2i} \left(\frac{\frac{n!}{i!(n - i)!}}{\frac{(2n)!}{(2i)! (2n - 2i)!}}\right)^3 &&\text{rearranging} \\
    &= \sum_{i = 1}^{n - 1} \binom{2n}{2i} \left(\frac{\binom{n}{i}}{\binom{2n}{2i}}\right)^3 \\
    &= \sum_{i = 1}^{n - 1} \frac{\binom{n}{i}^3}{\binom{2n}{2i}^2} 
\end{align*}
$$
</p>

Note that this is slightly overcounting (by a factor of 2 in fact) since for a cut of size $$2k$$, and the complementary cut of size $$2n - 2k$$, we count this cut $$(S, V \setminus S)$$ twice once for the $$i = k$$ case and another time for the $$i = n - k$$. However, this only changes a factor of 2 and asymptotically derives the same result, so we push through unfazed. Inspecting the summand and applying Stirlings more times than I can count gives us  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \frac{\binom{n}{i}^3}{\binom{2n}{2i}^2} &= \frac{\left(\frac{n!}{i!(n - i)!}\right)^3}{\left(\frac{(2n)!}{(2i)! (2n - 2i)!}\right)^2} \\
    &\approx \frac{\left(\left(\frac{n}{e}\right)^n \cdot \left(\frac{e}{i}\right)^i \cdot \left(\frac{e}{n - i}\right)^{n - i}\right)^3}{\left(\left(\frac{2n}{e}\right)^{2n} \cdot \left(\frac{e}{2i}\right)^{2i} \cdot \left(\frac{e}{2n - 2i}\right)^{2n - 2i}\right)^2} 
    && \text{Stirling's Approximation} \\
    &= \frac{\left(\frac{n^n}{e^n} \cdot \frac{e^i}{i^i}\cdot \frac{e^{n - i}}{(n - i)^{n - i}}\right)^3}{\left(\frac{(2n)^{2n}}{e^{2n}} \cdot \frac{e^{2i}}{(2i)^{2i}} \cdot \frac{e^{2n - 2i}}{(2n - 2i)^{2n - 2i}}\right)^2} = 
    \frac{\frac{n^{3n}}{i^{3i} (n - i)^{3(n - i)}}}{\frac{(2n)^{4n}}{(2i)^{4i} (2n - 2i)^{4(n - i)}}} \\
    &= \frac{\frac{n^{3n}}{i^{3i} (n - i)^{3(n - i)}}}{\frac{2^{4n} n^{4n}}{2^{4i} i^{4i} 2^{4(n - i)} (n - i)^{4(n - i)}}} = 
    \frac{\frac{n^{3n}}{i^{3i} (n - i)^{3(n - i)}}}{\frac{n^{4n}}{ i^{4i} (n - i)^{4(n - i)}}} &&\text{simplifying} \\
    &= \frac{n^{3n}}{i^{3i} (n - i)^{3(n - i)}} \cdot \frac{i^{4i} (n - i)^{4(n - i)}}{n^{4n}} = 
    \frac{i^i (n - i)^{n - i}}{n^n} &&\text{simplifying} 
\end{align*}
$$
</p>

We now turn our attention to bounding the following sum, for $$u = 3$$.  

<p style = "overflow-x:auto">
$$
    \Pr[G_k \text{ is disconnected}] \leq \frac{1}{n^{n}} \sum_{i = 1}^{n - 1} i^{i} (n - i)^{n - 1}
$$
</p>

Therefore, reiterating things so I don't lose sight of the goal  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr\bigg[G_k \text{ is disconnected}\bigg] &\leq \sum_{i = 1}^{n - 1} \frac{i^i (n - i)^{n - i}}{n^n} = 
    \frac{1}{n^n} \sum_{i = 1}^{n - 1} i^i (n - i)^{n - i} \\
    &\approx \frac{2}{n^n} \left(\sum_{i = 1}^{n/2} i^i (n - i)^{n - i} \right) && \text{since } i^i (n - i)^{n - i} \text{ is symmetric} \\ 
    &= \frac{2}{n^n} \left((n - 1)^{n - 1} + \sum_{i = 2}^{n/2} i^i (n - i)^{n - i} \right)
\end{align*}
$$
</p>

Now, getting slightly more formal with things. We define $$f : [2, n/2] \to \mathbb{R}$$ where $$f(x) = x^x (n - x)^{n - x}$$. Since $$f$$ is continuous, we also have that $$f$$ is bounded which is quite nice! Taking logs on both sides gives us  

<p style = "overflow-x:auto">
$$
\begin{align*}
    f(x) &= x^x (n - x)^{n - x} \\
    \log f(x) &= \log \bigg(x^x (n - x)^{n - x}\bigg) \\
    &= \log \bigg(x^x\bigg) + \log \bigg((n - x)^{n - x}\bigg) \\
    \log f(x) &= x \log x + (n - x) \log (n - x)
\end{align*} 
$$
</p>

We now argue that the function is decreasing, i.e. $$f'(x) < 0$$. We have  

<p style = "overflow-x:auto">
$$
\begin{align*}
    f'(x) / f(x) &= \frac{d}{dx} \left(\left(x \log x\right) + (n - x) \log (n - x)\right) \\
    &= \frac{d}{dx} \left(x \log x\right) + \frac{d}{dx} \left((n - x) \log (n - x)\right) \\
    &= 1 + \log x - \log (n - x) - 1 = \log x + \log (n - x) \\
    &= \log \left(\frac{x}{n - x}\right) < 0 && \text{since } x < n - x
\end{align*}
$$
</p>

where the last inequality follows from the fact that $$x \leq n/2$$, and so we have $$\frac{x}{n - x} < 1$$ and therefore $$\log \left(\frac{x}{n - x}\right) < 0$$.

Therefore the maximum of $$f$$ for $$2 \leq x \leq n/2$$ is attained at $$x = 2$$, which gives us the very 
useful fact that for all $$x \in [2, n/2]$$, $$f(x) \leq f(2)$$, i.e.  

<p style = "overflow-x:auto">
$$
    f(x) \leq 2^2 (n - 2)^{n - 2} = 4 (n - 2)^{n - 2}
$$
</p>

Putting all these facts together, we have 

<p style = "overflow-x:auto">
$$
\begin{align*}
    \Pr\bigg[G_k \text{ is disconnected}\bigg] &\leq \frac{2}{n^n} \left((n - 1)^{n - 1} + \sum_{i = 2}^{n/2} i^i (n - i)^{n - i} \right) \\
    &\leq \frac{2}{n^n} \left((n - 1)^{n - 1} + \sum_{i = 2}^{n/2} 4 (n - 2)^{n - 2} \right) &&\text{from the claim above} \\
    &\leq \frac{2}{n^n} \left((n - 1)^{n - 1} + 4 (n - 2)^{n - 2} \cdot \frac{n}{2} \right) \\
    &= \frac{2 (n - 1)^{n - 1}}{n^n} + \frac{4 (n - 2)^{n - 2}}{n^{n - 1}} \\
    &= \frac{2 \left(\frac{n - 1}{n}\right)^{n - 1}}{n} + \frac{4 \left(\frac{n - 2}{n}\right)^{n - 2}}{n} 
\end{align*}
$$
</p>

As $$n \to \infty$$, clearly  

<p style = "overflow-x:auto">
$$
    e^{-1 + 1/n} = e^{-1/n(n - 1)} \approx \left(1 - 1/n\right)^{n - 1} = \left(\frac{n - 1}{n}\right)^{n - 1} \to 1/e
$$
</p>

and 

<p style = "overflow-x:auto">
$$
    e^{-2 + 4/n} = e^{-2/n(n - 2)} \approx \left(1 - 2/n\right)^{n - 2} = \left(\frac{n - 2}{n}\right)^{n - 2} \to 1/e^2
$$
</p>

Taking limits, we get  

<p style = "overflow-x:auto">
$$
\begin{align*}
    \lim_{n \to \infty} \frac{2 \left(\frac{n - 1}{n}\right)^{n - 1}}{n} + \frac{4 \left(\frac{n - 2}{n}\right)^{n - 2}}{n} = 
    \lim_{n \to \infty} \left(\frac{2}{en} + \frac{4}{e^2 n}\right) = 0
\end{align*}
$$ 
</p>

which finally implies  

<p style = "overflow-x:auto">
$$
    \Pr\bigg[\mathcal{G}_k \text{ is disconnected}\bigg]  \to 0 \text{ as } n \to \infty \Longleftrightarrow 
    \Pr\bigg[\mathcal{G}_k \text{ is connected}\bigg] \to 1 \text{ as } n \to \infty
$$
</p>

and we are finally done. We have emerged victorious. 