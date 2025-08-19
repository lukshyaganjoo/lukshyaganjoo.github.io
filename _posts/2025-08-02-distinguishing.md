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
---

## introduction 
possibly the poster-child problem for an quantum computing class is the state discrimination problem. broadly speaking, the goal is to determine the unknown quantum state from a set of possible candidate states which are **known** to us the distinguisher. note that this problem is trivial classically since given two classical states of information, one can always simply distinguish between them by simply reading the bits of which they are comprised. as the astute reader is well aware by now, such is not possible with quantum states. 

## the problem itself 
formally, the version of the state discrimination problem we will be dealing with is the following. 

> Given a pure $$d$$-dimensional state $$\ket{\psi}\in (\mathbb{C}^{2})^{\otimes d}$$ 
> known to be either $$\ket{\psi_1}$$ or $$\ket{\psi_2}$$, the
> goal is to output which state $$\ket{\psi}$$ really is. 