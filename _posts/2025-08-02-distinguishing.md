---
layout: distill
title: the elevator pitch for quantum
description: today, we go distribution distinguishing
giscus_comments: true
date: 2025-08-02
featured: false

toc:
  - name: introduction
  - name: the problem itself
  - name: towards an optimal algorithm
  - subsections:
      - name: what the naive strategy buys you
      - name: a remark on the form of strategies we're considering
      - name: an optimal algorithm
  - name: generalizing to mixed states
---

## introduction

possibly the poster-child problem for an quantum computing class is the state discrimination problem. broadly speaking, the goal is to determine the unknown quantum state from a set of possible candidate states which are **known** to us as the distinguisher. note that this problem is trivial classically since given two classical states of information, one can always simply distinguish between them by simply reading the bits of which they are comprised. as the astute reader is well aware by now, such is not possible with quantum states; hence today's post.

## the problem itself

formally, the version of the state discrimination problem we will be dealing with is the following.

> Given a pure $$d$$-dimensional state $$\ket{\psi}\in (\mathbb{C}^{2})^{\otimes d}$$
> known to be either $$\ket{\psi_1}$$ or $$\ket{\psi_2}$$, the
> goal is to output which state $$\ket{\psi}$$ really is.

**remark:** there is a generalization of this problem where the distinguisher is handed a (possibly mixed) quantum state $$\rho \in \mathcal{L}(\mathbb{C}^{2^d})$$ and is tasked with deciphering whether they were handed the state $$\rho_1$$ or $$\rho_2$$. it turns out that the classical analog of this problem is well-defined. in essence it equivocates to distinguishing between probability distributions $$\{p\}, \{q\}$$ by drawing a single sample $$x$$. further generalizations involve distinguishing between not just $$2$$ states but rather a finite state $$\mathcal{S}$$.

in order to quantify the performance of the strategies we come up with (natural or otherwise); for any algorithm $\mathcal{A}$, define how well it distinguishes two states $\ket{\psi_1}$ and $\ket{\psi_2}$ by

$$
\Delta(\mathcal{A}) := \max(\Pr\left[\text{guess } \ket{\psi_1} \;\big|\; \ket{\psi_2}\right], \Pr\left[\text{guess } \ket{\psi_2} \;\big|\; \ket{\psi_2}\right])
$$

in words, $$\Delta$$ quantifies exactly the $$2$$ kinds of errors, we as distinguishers might make. either we guess $$\ket{\psi_1}$$ when given $$\ket{\psi_2}$$ or we guess $$\ket{\psi_2}$$ when given $$\ket{\psi_1}$$.

## towards an optimal algorithm

### what the naive strategy buys you

the most natural strategy is to measure in a basis for which $$\ket{\psi_1}$$ is a basis element
and guess "outcome $$1$$" if the measurement is $$\ket{\psi_2}$$ otherwise. The measurement error from this process via Born's rule can be written as

<p style = "overflow-x:auto">
$$
\begin{align*}
  \Delta(\mathcal{A}) &:= \max\left(\left|\langle \psi_1 | \psi_2 \rangle\right|^2, \left|\langle \psi_2 | \psi_1 \rangle\right|^2\right) = \left|\langle \psi_1 | \psi_2 \rangle\right|^2
\end{align*}
</p>
$$given the wording of the title of this section, it might not be surprising to most; that it is possible to do better.

### a remark on the form of strategies we're considering

I've been somewhat vague with the usage of the term "strategies" over here so before we dive into what the best one can hope for is, let us clarify the family of **distinguishing strategies** we are allowed to use. General strategies here are of the form

- Append some number of ancilla qubits to $$\ket{0}^n$$
- Apply a unitary $$\mathbf{U}$$ to the joint system.
- Perform a two-outcome [projective measurement](https://en.wikipedia.org/wiki/Measurement_in_quantum_mechanics#Projective_measurement) $$\{\mathbf{P}, \mathbb{I} - \mathbf{P}\}$$.

After sufficient amounts of meditation, one can show that steps $$2$$ and $$3$$ can be combined, i.e. the projective measurement we now perform is $$\{\mathbf{U}\mathbf{P}\mathbf{U}^\dagger, \mathbb{I} - \mathbf{U}\mathbf{P}\mathbf{U}^\dagger\}$$. There is one more simplification we can make that is slightly more involved. It turns out that this entire process of appending ancillas and performing a projective-measurement is equivalent to performing a [POVM](<https://en.wikipedia.org/wiki/Measurement_in_quantum_mechanics#Generalized_measurement_(POVM)>). Therefore after all is said and done, the family of strategies we will be considering are of the form

- Perform "some" two-outcome POVM

### an optimal algorithm

> There exists a quantum strategy $$\mathcal{A}$$ for which
> $$\Delta(\mathcal{A}) := 1/2 + \sqrt{1 - |\braket{\psi_0|\psi_1}|^2}$$

**proof:** Our strategy $$\mathcal{A}$$ is as follows. Let $$\ket{\mathbf{v}_0}, \ket{\mathbf{v}_1}$$ be states in the span of $$\ket{\psi_0}, \ket{\psi_1}$$ such that $$\langle \mathbf{v}_0 \mid \mathbf{v}_1 \rangle = 0$$ and they are symmetric with respect to the angle bisector of $$\ket{\psi_0}$$ and $$\ket{\psi_1}$$ where $$\ket{\mathbf{v}_i}$$ is closer to $$\ket{\psi_i}$$. On outcome $$\ket{\mathbf{v}_i}$$ we guess $$\ket{\psi_i}$$. Illustratively, we have the following diagram.

<p style="text-align:center;">
<img src = "/assets/img/image-2.png" alt = "optimal distinguishing strategy" style = "width: 100%; margin: auto;">
</p>

It now remains to compute $$\Delta$$ for this strategy. Notice from the above description, that our strategy $$\mathcal{A}$$ is symmetric with respect to $$\ket{\psi_1}$$ and $$\ket{\psi_2}$$. Therefore without loss of generality, we may assume $$\Delta = | \langle \mathbf{v}_1 \mid \psi_1 \rangle|^2$$. Making use of the fact that the basis in which the measurement is made
is orthonormal and the vectors $$\ket{\mathbf{v}_0}, \ket{\mathbf{v}_1}$$ are completely real, one has

$$
\begin{align*}
  \Delta &= \left| \langle \mathbf{v}_1 \mid \psi_1 \rangle\right|^2
  = \big|\braket{\psi_1|\mathbf{v}_1}\big|^2 = \|{\psi_0} \|^2 \|\mathbf{v}_0 \|^2 \cdot \cos(\angle (\psi_1, \mathbf{v}_1))^2 \\
  &= \cos^2\left(\frac{\pi/2 - \theta}{2}\right) = \bigg| \frac{1}{2} + \frac{1}{2} \cos\left(\frac{\pi}{2} - \theta\right) \bigg|\\
  &= \left|\frac{1}{2} + \frac{1}{2} \sin(\theta)\right| = 1/2 + \sqrt{1 - |\braket{\psi_0|\psi_1}|^2}
\end{align*}
$$

**remark**: in this case, the POVM being applied is $$\{ |\mathbf{v}\rangle \langle \mathbf{v}|\}, \mathbb{I} - |\mathbf{v}\rangle \langle \mathbf{v}|\}$$ where $$\ket{\mathbf{v}}$$ is the angle bisector between $$\ket{\psi_1}, \ket{\psi_2}$$. Phrasing things here in terms of born's rule instead of the POVM language is convenient since we're dealing with pure states. However this generalization will be critical when we are dealing with mixed states (and shows up in demonstrating optimality)

## generalizing to mixed states
