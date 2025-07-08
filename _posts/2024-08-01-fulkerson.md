---
layout: distill
title: why gym rats love ford-fulkerson
description: what most people associate with the passage of water and time; a nightmarish combinatorial optimization problem for those in cs.
tags: math
giscus_comments: false
date: 2022-02-24
featured: false

bibliography: 2018-12-22-distill.bib

toc:
  - name: background and definitions
  - name: the problem
  - name: the solution and where ford and fulkerson come in
  - name: the proof
  - name: references
---

In any standard algorithms class, there's going to be an entire section of the course dedicated to what computer scientists refer to as "flow". Besides being creatively named, it is also quite powerful in solving a variety of problems. For the purposes of motivation, I will go over some background, one of the more important network flow algorithms, and an application of this algorithm in the context of proving a seemingly unnatural equivalence.

## background and definitions 
- a **flow network** is a directed graph $$G = (V, E)$$ with a capacity function $$c : E \rightarrow \mathbb{R}^+$$ and a source $$s \in V$$ and a sink $$t \in V$$.
- in the context of this definition, a **flow** moves units of water from the source $$s$$ to 
the sink $$t$$ in the graph $$G$$. water can only be created from the source $$s$$ and can only 
disappear at the sink $$t$$.
- every edge $$e = (u, v) \in E$$ has a capacity $$c(e)$$ and the flow on a given edge $$e$$, has to be less than or equal to the capacity of that given edge, i.e. $$0 \leq f(e) \leq c(e)$$. (note here that based on these constraints, edges can't have negative flow).
- for every vertex $$u \in V \setminus \\{s, t\\}$$, the total flow entering the vertex $$u$$ must be equal to the total flow leaving the vertex $$u$$, i.e. $$\sum \limits_{v : e = (v, u) \in E} f(e) = \sum \limits_{u : e = (u, t) \in E} f(e)$$. 
- the value of a flow is defined as the net flow leaving the vertex $$s$$ or equivalently the flow entering the vertex $$t$$ (note this equivalence exists because of the conservation constraint we've defined above).

## the problem 
- given a flow network $$G = (V, E)$$ with a capacity function $$c : E \rightarrow \mathbb{R}^+$$ and a source $$s \in V$$ and a sink $$t \in V$$, it isn't unereasonable to try and find the maximum flow that can travel through the network. this is a somewhat interesting question to ask because the naive idea of simply sending as much flow as you can on a given edge doesn't really work out. 
- consider the following flow network 
<p style="text-align:center;">
<img src = "/assets/img/network1.png" alt = "flow network 1" style = "width: 100%; margin: auto;">
</p>
- the naive idea of finding a path from $$s$$ to $$t$$ and sending as much flow as possible on the edges given by that path doesn't quite work. Consider the following path from $$s$$ to $$t$$ given by 
<p style="text-align:center;">
<img src = "/assets/img/network2.png" alt = "flow network 2" style = "width: 100%; margin: auto;">
</p>
- since the minimimum edge capacity on the given path is 20 units of flow, 
we send 20 units of flow from $$s$$ to $$t$$ on the given path, and given that all the edges have the same capacity, there is no redirection happening here, where we send exactly 20 units from $$s$$ to $$t$$ as shown below 
<p style="text-align:center;">
<img src = "/assets/img/network3.png" alt = "flow network 3" style = "width: 100%; margin: auto;">
</p>

## the solution and where ford and fulkerson come in
- we introduce a new concept called a **residual graph**. the residual graph of a graph $$G$$ is defined as a graph $$\mathcal{R} = (V, E)$$, where it has the exact same vertices and edges as the original graph, but differs from the original graph with regards to the capacities along each of the edges. 
- if the original graph has an edge $$(u, v)$$ with capacity $$c$$, and the flow sends along $$f_{u, v}$$ along the given edge, we do the following 
  - we include the edge $$(u, v)$$ in $$\mathcal{R}$$ with capacity $$c - f_{u, v}$$ as long as $$c - f_{u, v} > 0$$.
  - we include the edge $$(v, u)$$ in $$\mathcal{R}$$ with capacity $$f_{u, v}$$ as long as $$f_{u, v} > 0$$.
- ### the algorithm (ford and fulkerson)
  - while ($$\texttt{true}$$)
    - run $$\texttt{BFS}$$ on $$\mathcal{R}$$ starting from $$s$$.
    - record the predecessors to find an $$s-t$$ path.
    - if you can't reach $$t$$, then $$\texttt{break}$$.
    - iterate through the path and find the minimum residual capacity edge $$c$$.
    - add $$c$$ to the flow on the path (on every edge in the path).
    - update the residual graph $$\mathcal{R}$$.
  - ## runtime: 
    - $$\mathcal{O}(\vert E \vert \cdot f)$$ where $$f$$ is the maximum flow.
- we define an **$$(s, t)$$-cut** for a graph $$G$$ to be a split of vertices into two sets $$(S, T)$$ where $$S \subseteq V$$ and $$T \subseteq V$$ such that $$s \in S$$ and $$t \in T$$ and every other vertex in $$V$$ is in one of $$S$$ or $$T$$.  more formally, to be a cut, the following requirements need to be satisfied 
  - $$S \cup T = V$$
  - $$S \cap T = \varphi$$
  - $$s \in S, t \in T$$
- the **capacity** of a cut $$C(S, T)$$ denoted $$c(S, T)$$ is defined as the sum of the capacities of the edges $$(u, v)$$ with $$u \in S$$ and $$v \in T$$, i.e. 
  
  $$
  c(S, T) = \sum_{u \in S} \sum_{v \in T} c(u, v)
  $$

- this definition of capacity is somewhat intuitive and in fact it suggests that we can define the flow of a cut in  a similar manner.
- given a cut $$C(S, T)$$, with capacity $$c(S, T)$$ and a flow $$f$$, the **flow** of a cut $$C(S, T)$$ is defined as the flow going from $$S$$ to $$T$$ minus the flow going from $$T$$ to $$S$$, i.e. 
  
  $$
  f(S, T) = \sum_{u \in S} \sum_{v \in T} f(u, v) - 
  \sum_{u \in S} \sum_{v \in T} f(v, u)
  $$

we finally stop the dilly-dallying and get to the main point of this post, the max-flow min-cut theorem.

> max-flow min-cut theorem
>
> Let $$(\mathcal{G}, s, t, c)$$ be a flow network, $$C(S, T)$$ be an $$s-t$$ cut, and $$f$$ be a flow in $$\mathcal{G}$$, then the following are equivalent: 
> - $$f$$ is a maximum flow in $$\mathcal{G}$$.
> - $$\mathcal{G}_f$$ contains no augmenting paths.
> - there exists a cut $$C(S, T)$$ such that $$c(S, T) = \text{val}(f)$$.


## the proof

> Lemma 1
>
> Let $$(\mathcal{G}, s, t, c)$$ be a flow network, $$C(S, T)$$ be an $$s-t$$ cut, and $$f$$ be a flow in $$\mathcal{G}$$, then: 
>
> <p style = "overflow-x:auto">
> $$\begin{align*}f(S, T) \leq c(S, T)\end{align*}$$
> </p>


**proof:** For every edge $$(u, v)$$ by a consequence of the capacity constraint, we know that $$f(u, v) \leq c(u, v)$$. Therefore, we can ascertain 
<p style = "overflow-x:auto">
$$
\begin{align*}
    f(S, T) &= \sum_{u \in S} \sum_{v \in T} f(u, v) - 
    \sum_{u \in S} \sum_{v \in T} f(v, u) && \text{definition of flow} \\
    &\leq \sum_{u \in S} \sum_{v \in T} f(u, v) &&\text{non-negativity of a flow} \\
    &\leq \sum_{u \in S} \sum_{v \in T} c(u, v) &&\text{capacity constraint} \\
    &= c(S, T) &&\text{definition of capacity}
\end{align*}
$$
</p>
The larger consequence of this lemma is that for **any cut** you choose in the flow network, the flow going through $$C(S, T)$$ is always bounded by its capacity.

> Lemma 2
>
> Let $$(\mathcal{G}, s, t, c)$$ be a flow network, $$C(S, T)$$ be an $$s-t$$ cut, and $$f$$ be a flow in $$\mathcal{G}$$, with $$v \in T$$, then: 
>
> <p style = "overflow-x:auto">
> $$
    \begin{align*}f(S, T) = f(S \cup \{v\}, T \setminus \{v\})
    \end{align*}
$$
> </p>


**proof:** Let $$C(S, T)$$ be any $$s-t$$ cut and $$v$$ an element in $$T$$. Remove $$v$$ from $$T$$ and place it in $$S$$. Let us now evaluate the flow of the new cut (call it $$C'(S', T')$$) where $$S' = S \cup \{v\}$$ and $$T' = T \setminus \{v\}$$.

For the sake of notational convenience, we define the following sets 

<p style = "overflow-x:auto">
$$
\textsf{In}(v) = \{(u, v) \in E \mid u \in V\} \quad \text{and} \quad \textsf{Out}(v) = \{(v, w) \in E \mid w \in V\}
$$
</p>

Intuitively, $$\textsf{In}(v)$$ is the set of edges going into $$v$$ and $$\textsf{Out}(v)$$ is the set of edges going out of $$v$$. We know that from the conservation of flow 

$$\sum \limits_{(u, v) \in \textsf{In}(v)} f(u, v) = \sum \limits_{(v, w) \in \textsf{Out}(v)} f(v, w)$$

We now partition $$\textsf{In}(v)$$ and $$\textsf{Out}(v)$$ based on where the end-points of the edges in the set fall as follows 
<p style = "overflow-x:auto">
$$
\begin{align*}
    \textsf{In}_{S}(v) &= \big\{(u, v) \in E \mid u \in S\big\} \\
    \textsf{In}_{T}(v) &= \big\{(u, v) \in E \mid u \in T\big\} \\
    \textsf{Out}_{S}(v) &= \big\{(v, w) \in E \mid w \in S\big\} \\
    \textsf{Out}_{T}(v) &= \big\{(v, w) \in E \mid w \in T\big\}
\end{align*}
$$
</p>
Finally let us evaluate the flow of this new cut. Moving $$v$$ into $$S$$ result in losing $$v$$'s contribution in the original cut capacity but also in gaining the contribution of the edges going out of $$v$$, and therefore: 

<p style = "overflow-x:auto">
$$
\begin{align*}
    f(S', T') &= f(S, T) - \sum \limits_{(u, v) \in \textsf{In}_{S}(v)} f(u, v) - \sum \limits_{(u, v) \in \textsf{In}_{T}(v)} f(u, v) \\
    &+ \sum \limits_{(v, w) \in \textsf{Out}_{S}(v)} f(v, w) + \sum \limits_{(v, w) \in \textsf{Out}_{T}(v)} f(v, w) \\
    &= f(S, T) - \sum \limits_{(u, v) \in \textsf{In}(v)} f(u, v) + \sum \limits_{(v, w) \in \textsf{Out}(v)} f(v, w) &&\text{since } \textsf{In}_{S}(v) \cup \textsf{In}_{T}(v) = \textsf{In}(v) \\
    &= f(S, T) &&\text{by conservation of flow}
\end{align*}
$$
</p>

> Lemma 3
>
> Let $$(\mathcal{G}, s, t, c)$$ be a flow network, $$C(S, T)$$ be an $$s-t$$ cut, and $$f$$ be a flow in $$\mathcal{G}$$, then:
>
> <p style = "overflow-x:auto">
> $$\begin{align*}
    f(S, T) = \text{val}(f)
  \end{align*}
$$
> </p>


**proof:** consider applying lemma 2 to the following cut $$C(S, T)$$ where $$S = \{s\}$$ and $$T = V \setminus \{s\}$$, then:

$$f(\{s\}, V \setminus \{s\}) = f(\{s\} \cup S', V \setminus (\{s\} \cup S')) = f(S', T')$$

Essentially this implies that the flow of **any cut** is equal to the flow of the cut $$C(S, T)$$ where $$S = \{s\}$$ and $$T = V \setminus \{s\}$$. How nice is that!! You may ask why is this nice? Well evaluating the flow of $$C(S, T)$$ is much easier than evaluating the flow of any other cut. This is because the flow of $$C(S, T)$$ is simply the flow leaving the source and this is the flow of the network :)

<p style = "overflow-x:auto">
$$
\begin{align*}
\text{val}(f) &= \sum_{(u, v) \in E} f(u, v) \\
&= f(\{s\}, V \setminus \{s\}) = f(S, T) &&\text{by lemma 2}
\end{align*}
$$
</p>

> Corollary 1
>
> Let $$(\mathcal{G}, s, t, c)$$ be a flow network, $$C(S, T)$$ be an $$s-t$$ cut, and $$f$$ be a flow in $$\mathcal{G}$$, then:
>
> <p style = "overflow-x:auto">
> $$\begin{align*}\text{val}(f) \leq c(S, T)\end{align*}$$
> </p>


now FINALLY, we can proceed with the proof of the max-flow min-cut theorem. we want to show that the 3 points of the theorem are equivalent. in the same vain, 
- $$1 \implies 2:$$ let $$f$$ be a max flow and suppose that $$\mathcal{G}_f$$ still has an augmenting path $$\mathcal{P}$$. then we can increase the flow of $$f$$ simply by augmenting $$f$$ along $$\mathcal{P}$$, which contradicts the assumption that $$f$$ is a max flow. therefore $$G_f$$ has no augmenting paths and $$f$$ is a max flow.
- $$2 \implies 3:$$ 
  suppose that $$\mathcal{G}_f$$ has no augmenting paths. consider the cut $$C(S, T)$$ such that $$c(S, T) = \text{val}(f)$$. let $$S$$ denote the set of vertices reachable from $$s$$. if there is an augmenting $$s, t$$ path from $$s$$ to a vertex $$v$$, then $$v \in S$$. Since there are no augmenting paths, $$t \notin S$$. let $$T = V \setminus S$$ and therefore $$t \in T$$. This implies that $$C(S, T)$$ is a valid $$s-t$$ cut. We now proceed with evaluating the flow across $$C(S, T)$$. 

  Consider an edge $$(u, v)$$ crossing the cut, i.e. $$u \in S$$ and $$v \in T$$. By definition $$c_f(u, v)$$ denotes the capacity along the edge $$(u, v)$$ in the residual graph $$\mathcal{G}_f$$. As a consequence of the terminating condition of $$\tt{ford-fulkerson}$$ we have that $$c_f(u, v) = 0$$ (otherwise there would have been an augmenting $$s, v$$ path and $$v$$ would be reachable from $$s$$.)

  if $$(u, v)$$ is an edge of $$\mathcal{G}$$ (the original graph), then since $$c_f(u, v) = 0$$, by definition $$c(u, v) - 
  f(u, v) = 0$$ and therefore $$f(u, v) = c(u, v)$$. if $$(u, v)$$ is not an edge of $$\mathcal{G}$$ (it was added by the residual graph), then $$f(v, u) = 0$$. this gives us that 
  <p style = "overflow-x:auto">
  $$
  \begin{align*}
  \text{val}(f) &= f(S, T) &&\text{lemma 3} \\
  &= \sum \limits_{u \in S} \sum \limits_{v \in T} f(u, v) - \sum \limits_{u \in S} \sum \limits_{v \in T} f(v, u) \\
  &= \sum \limits_{u \in S} \sum \limits_{v \in T} f(u, v) &&\text{since } f(v, u) = 0 \\
  &= \sum \limits_{u \in S} \sum \limits_{v \in T} c(u, v) &&\text{since } f(u, v) = c(u, v) \\
  &= c(S, T)
  \end{align*}
  $$
  </p>
- $$3 \implies 1:$$ let $$C(S, T)$$ be a cut with capacity $$c(S, T) = \text{val}(f)$$ and let $$f'$$ be the maximum flow in $$\mathcal{G}$$, i.e. $$\text{val}(f) \leq \text{val}(f')$$. Since $$\text{val}(f) = c(S, T)$$, we have that $$c(S, T) \leq \text{val}(f')$$. By corollary 1, we have that $$\text{val}(f') \leq c(S, T)$$ and therefore $$\text{val}(f) = c(S, T) = \text{val}(f')$$. This implies that $$f$$ is a max flow and we're done :)

## references 
- [robbie's perspective on flow from uw's algos class](https://courses.cs.washington.edu/courses/cse421/23wi/lecture/18-flow2.pdf)
- [a self-contained proof @ toronto](https://www.cs.toronto.edu/~lalla/373s16/notes/MFMC.pdf)
- [yet another proof of könig and menger's theorems](https://www.math.uchicago.edu/~may/VIGRE/VIGRE2009/REUPapers/Staples-Moore.pdf)