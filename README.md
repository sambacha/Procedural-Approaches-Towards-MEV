---
title: Procedural approaches towards Maximal Extracted Value
description: Procedural approaches towards establishing simple Maximal Extracted Value for constant function market makers
version: 2022.05.29
authors: Alexander Bradley, Sam Bacha
---

# Procedural Approaches Towards MEV

> Preprint, Procedural approaches towards Maximal Extracted Value


## Optimising Swaps for Constant Product Automated Market Makers (Draft)

Alexander Bradley <github.com/sandybradley>
Sam Bacha <github.com/sambacha>

> WORK IN PROGRESS - EDITING

- [Procedural Approaches Towards MEV](#procedural-approaches-towards-mev)
  * [Optimising Swaps for Constant Product Automated Market Makers (Draft)](#optimising-swaps-for-constant-product-automated-market-makers--draft-)
  * [Abstract](#abstract)
  * [PREFACE](#preface)
    + [Abbreviations](#abbreviations)
  * [Chapter 1](#chapter-1)
    + [Basics](#basics)
      - [1.1 Constant Product Automated Market Maker](#11-constant-product-automated-market-maker)
      - [1.2 Quotient rule](#12-quotient-rule)
      - [1.3 Quadratic formula](#13-quadratic-formula)
  * [Consequent DEX Arbitrage](#consequent-dex-arbitrage)
      - [Token amount swap path](#token-amount-swap-path)
    + [2.1 Optimal simple DEX arbitrage size](#21-optimal-simple-dex-arbitrage-size)
  * [Triangular Arbitrage](#triangular-arbitrage)
      - [Token amount swap path](#token-amount-swap-path-1)
    + [3.1 Optimal triangular arbitrage size](#31-optimal-triangular-arbitrage-size)
  * [3.2 Improvements](#32-improvements)
  * [Citations](#citations)


## Abstract

Manifold currently offers Sushiswap users the option to submit private
swaps for efficient execution; that is reliable (not reverted of
failed), fast (within 1 minute), best price and low to no gas fee. This is acheived through a Miner Extractable Value (MEV) relay, a realtime
bundle engine and a user reward system. Herein, optimal MEV swap bundles
are derived for Constant Product Automated Market Makers (CPAMMs), given
a user swap flow and liquidity state. Three bundle cases are considered as a tiered fallback system. In the first case, suf- ficiently large user swaps trigger profitable sandwich bundles. Bundles are batched swaps for best execution and minimal slippage. Second, cross Decentralised Ex- change (DEX) markets are analysed for profitable arbitrage, which user swaps ap- pended. Third, triangular arbitrage opportunities are analysed both within and across DEX's, in which user swaps are appended. Finally, use of Aave flashloans enables bundle execution security and capitalisation of optimal sizes alculated within this report.

## PREFACE

### Abbreviations

MEV Maximal Extractable Value 
DEX Decentralised Exchange 
CPAMM Constant Product Automated Market Maker

## Chapter 1

### Basics

Derivations within this report utilise a few basic concepts explicitly
outlined in this chapter.

#### 1.1 Constant Product Automated Market Maker

Constant Product Automated Market Makers (CPAMMs) are Ethereum contracts for token liquidity pairs. Uniswap V2 was the first to adopt this protocol. Sushiswap, Bancor, Curve, Kyber, Balancer, Honeyswap, PancakeSwap and Quickswap all use the same protocol. They are all governed by the constant product formula given in equation 1.1 (Uniswap, 2020).


$$
k=R_{\alpha} R_{\beta}
$$

Where $R_{\alpha}$ corresponds to the Reserves of token $\alpha, R_{\beta}$ to the Reserves of token $\beta$ within the pair contract and $k$ the constant invariant.

A swap trading $\Delta \beta$ tokens for $\Delta \alpha$ must satisfy equation $1.2$ (Guillermo Angeris, 2019).

$$
\begin{aligned}
&k=\left(R_{\alpha}-\Delta \alpha\right)\left(R_{\beta}+\gamma \Delta \beta\right) \\
&\gamma=1-f e e
\end{aligned}
$$

Where the fee on Uniswap V2 and Sushiswap is $0.3 \%$. For big integer math, equtaion $1.3$ can be written in the form of equation 1.4.

$$
\gamma=\frac{997}{1000}
$$


From equations $1.1$ and $1.2$ we can derive an equations for the expected amounts out and in, given in equations $1.5$ and 1.6.

$$
\begin{aligned}
\text { amountOut }: \Delta \alpha &=\frac{997 R_{\alpha} \Delta \beta}{1000 R_{\beta}+997 \Delta \beta} \\
\text { amountIn }: \Delta \beta &=\frac{1000 R_{\beta} \Delta \alpha}{997\left(R_{\alpha}-\Delta \alpha\right)}
\end{aligned}
$$

Post swap, the new liquidity reserves are modified as shown in equations $1.7$ and 1.8.

$$
\begin{aligned}
&R_{\alpha} \text { new }=R_{\alpha} \text { old }-\Delta \alpha \\
&R_{\beta} n e w=R_{\beta} \text { old }+\Delta \beta
\end{aligned}
$$

Therefore sequential swaps can be simulated off-chain in a deterministic way, given the current liquidity state.

#### 1.2 Quotient rule
For complex differentiation, the quotient rule can be applied. This can be found in any high school text book and is given by equation $1.9$.

$$
\frac{f(x)}{g(x)}=\frac{f^{\prime} g-g^{\prime} f}{g^{2}}
$$

Where $f$ and $g$ are differentiable functions of $x$. $f^{\prime}$ and $g^{\prime}$ represent corresponding differentials.

#### 1.3 Quadratic formula
Generic roots to quadratic equations of the form in equation $1.10$ can be solved by by the generic quadratic formula given in equation 1.11. Again, this can be found in any high school text book.[^1](/AOKla4L1QaCiA5qtFknCTg)

$$
\begin{aligned}
&0=a x^{2}+b x+c \\
&x=\frac{-b \pm \sqrt{b^{2}-4 a c}}{2 a}
\end{aligned}
$$
Where `a`',`b`' and `c`' are constants and x is the unknown variable.

<p style="text-align:right;"> 1.11 </p>

## Consequent DEX Arbitrage

Consequent DEX arbitrage consists of a single swap on one DEX followed by the reverse swap on another. Manifold's engine builds all possible simple DEX swap routes from it own DEX liquidity state data, calculates optimal sizes and picks the top profit trade.[^2](/0u_9F1NgSUefI3Pp0qH4-Q)

#### Token amount swap path

$$
\begin{array}{ll}
DEX_0: & \Delta \beta_{0} \Rightarrow \Delta \alpha_{0} \\
DEX_1: & \Delta \alpha_{0} \Rightarrow \Delta \beta_{1}
\end{array}
$$

### 2.1 Optimal simple DEX arbitrage size
From equation 1.5, the definition of a consequent DEX arbitrage for CPAMMs can be written in the form of equations $2.3$ and 2.4.

$$
\begin{aligned}
\text { amountOutDEX0 : } \Delta \alpha_{0} &=\frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}} \\
\text { amountOutDEX } 1: \Delta \beta_{1} &=\frac{997 R_{\beta 1} \Delta \alpha_{0}}{1000 R_{\alpha 1}+997 \Delta \alpha_{0}}
\end{aligned}
$$

<p style="text-align:right;"> 2.3-4</p>

Profit of the arbitrage is simply the amount out of the second trade minus the amount in of the first, shown by equation 2.5.

$$
\text { profit: } y=\Delta \beta_{1}-\Delta \beta_{0}
$$
<p style="text-align:right;">2.5</p>

Substituting equation $2.3$ into equation $2.4$, we get equation $2.6$.

$$
\begin{aligned}
\Delta \beta_{1} &=\frac{997 R_{\beta 1} \frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}}}{1000 R_{\alpha 1}+997 \frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}}} \\
&=\frac{997^{2} R_{\beta 1} R_{\alpha 0} \Delta \beta_{0}}{\left(1000 R_{\beta 0}+997 \Delta \beta_{0}\right) 1000 R_{\alpha 1}+997^{2} R_{\alpha 0} \Delta \beta_{0}}
\end{aligned}
$$

Since we are looking for the optimal amount In $\left(\Delta \beta_{0}\right)$, we can make the following simplifications.

$$
\begin{aligned}
\text { let } x &=\Delta \beta_{0} \\
\text { let } C_{A} &=997^{2} R_{\beta 1} R_{\alpha 0} \\
\text { let } C_{B} &=1000^{2} R_{\beta 0} R_{\alpha 1} \\
\text { let } C_{C} &=997000 R_{\alpha 1} \\
\text { let } C_{D} &=997^{2} R_{\alpha 0}
\end{aligned}
$$

Thus equation $2.7$ can be reduced to equation 2.13.

$$
\Delta \beta_{1}=\frac{C_{A} x}{C_{B}+x\left(C_{C}+C_{D}\right)}
$$

<p style="text-align:right;">2.13</p>

Therfore the profit (y), from equation $2.5$ can be expressed in terms of the amount In $( x )$, shown in equation 2.14.

$$
\begin{aligned}
y &=\frac{C_{A} x}{C_{B}+x\left(C_{C}+C_{D}\right)}-x \\
&=\frac{C_{A} x-x\left(C_{B}+x\left(C_{C}+C_{D}\right)\right)}{C_{B}+x\left(C_{C}+C_{D}\right)} \\
&=\frac{x\left(C_{A}-C_{B}\right)-x^{2}\left(C_{C}+C_{D}\right)}{C_{B}+x\left(C_{C}+C_{D}\right)} \\
&=\frac{x C_{F}-x^{2} C_{G}}{C_{B}+x C_{G}}
\end{aligned}
$$
<p style="text-align:right;"> 2.14-2.17 </p>

Where:

$$
\begin{aligned}
&C_{F}=C_{A}-C_{B} \\
&C_{G}=C_{C}+C_{D}
\end{aligned}
$$
<p style="text-align:right;">2.18-2.19 </p>

Maximum profit occurs at a turning point i.e. where the gradient or differential is zero, shown in *equation 2.20*.

$$
\frac{d y}{d x}=0
$$

<p style="text-align:right;">2.20</p>



Since we have a complex equation for differentiating, we can use the quotient rule from equation 1.9. Numerator and denominator differentials are shown in equations $2.24$ and $2.25$.

$$
\begin{aligned}
\frac{d y}{d x} &=\frac{d \frac{f(x)}{g(x)}}{d x} \\
f(x) &=x C_{F}-x^{2} C_{G} \\
g(x) &=C_{B}+x C_{G} \\
\frac{f(x)}{d x} &=C_{F}-2 x C_{G} \\
\frac{g(x)}{d x} &=C_{G}
\end{aligned}
$$

Combining the quotient rule with equation $2.20$, we get equation $2.26$, which expands to equation $2.27$.

$$
\begin{aligned}
f^{\prime} g &=g^{\prime} f \\
\left(C_{F}-2 x C_{G}\right)\left(C_{B}+x C_{G}\right) &=C_{G}\left(x C_{F}-x^{2} C_{G}\right)
\end{aligned}
$$

Equation $2.27$ can be re-arranged to form a generic quadratic equation $2.28$ and so the parameters can be defined for the quadratic solution in equation 2.29.

$$
x^{2} C_{G}^{2}+x\left(2 C_{B} C_{G}\right)-C_{B} C_{F}=0
$$

Solution to the optimal simple DEX arbitrage size for a given swap is shown in equation 2.29.

$$
x^{*}=\frac{-\left(2 C_{B} C_{G}\right) \pm \sqrt{\left(2 C_{B} C_{G}\right)^{2}-4\left(C_{G}^{2}\right)\left(-C_{B} C_{F}\right)}}{2 C_{G}^{2}}
$$

### $2.2$ Improvements

██████
~~REDACTED~~
██████

## Triangular Arbitrage

Triangular arbitrage consists of 3 adjoining distinct market swaps, on any combination of DEX's, starting and ending on the same token with 2 other unique tokens in the path. Manifold's engine builds all possible triangular swap routes from it's own DEX liquidity state data, calculates optimal sizes and picks the top profit trade.

#### Token amount swap path

$$
\begin{array}{cc}
SWAP_0: & \Delta \beta_{0} \Rightarrow \Delta \alpha_{0} \\
SWAP_1: & \Delta \alpha_{0} \Rightarrow \Delta \kappa_{1} \\
SWAP_2: & \Delta \kappa_{1} \Rightarrow \Delta \beta_{2}
\end{array}
$$

<p style="text-align:right;">3.1-3</p>

### 3.1 Optimal triangular arbitrage size

From equation $1.5$, the definition of a triangular arbitrage for CPAMMs can be written in the form of equations $3.4$ and 3.5.

$$
\begin{aligned}
\text { amountOut Swap0 }: \Delta \alpha_{0} &=\frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}} \\
\text { amountOut Swap } 1: \Delta \kappa_{1} &=\frac{997 R_{\kappa 1} \Delta \alpha_{0}}{1000 R_{\alpha 1}+997 \Delta \alpha_{0}} \\
\text { amountOut Swap } 2: \Delta \beta_{2} &=\frac{997 R_{\beta 2} \Delta \kappa_{1}}{1000 R_{\kappa 2}+997 \Delta \kappa_{1}}
\end{aligned}
$$

<p style="text-align:right;">3.4-6</p>

Where $\kappa$ is introduced as the third token.

Profit of the arbitrage is simply the amount out of the third trade minus the amount in of the first, shown by equation 3.7.

$$
\text { profit: } y=\Delta \beta_{2}-\Delta \beta_{0}
$$

<p style="text-align:right;">3.7</p>

Substituting equation $3.4$ into equation $3.5$, we get equation $3.8$.

$$
\begin{aligned}
\Delta \kappa_{1} &=\frac{997 R_{\kappa 1} \frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}}}{1000 R_{\alpha 1}+997 \frac{997 R_{\alpha 0} \Delta \beta_{0}}{1000 R_{\beta 0}+997 \Delta \beta_{0}}} \\
&=\frac{997^{2} R_{\kappa 1} R_{\alpha 0} \Delta \beta_{0}}{\left(1000 R_{\beta 0}+997 \Delta \beta_{0}\right) 1000 R_{\alpha 1}+997^{2} R_{\alpha 0} \Delta \beta_{0}}
\end{aligned}
$$

<p style="text-align:right;">3.8-9</p>

Substituting equation $3.9$ into equation $3.6$, we get equation $3.10$.

$$
\begin{aligned}
\Delta \beta_{2} &=\frac{997 R_{\beta 2} \frac{997^{2} R_{\kappa 1} R_{\alpha 0} \Delta \beta_{0}}{\left(1000 R_{\beta 0}+997 \Delta \beta_{0}\right) 1000 R_{\alpha 1}+997^{2} R_{\alpha 0} \Delta \beta_{0}}}{1000 R_{\kappa 2}+997 \frac{997^{2} R_{\kappa 1} R_{\alpha 0} \Delta \beta_{0}}{\left(1000 R_{\beta 0}+997 \Delta \beta_{0}\right) 1000 R_{\alpha 1}+997^{2} R_{\alpha 0} \Delta \beta_{0}}} \\
&=\frac{997^{2} R_{\kappa 1} R_{\alpha 0} \Delta \beta_{0}}{\left.\left(\left(1000 R_{\beta 0}+997 \Delta \beta_{0}\right) 1000 R_{\alpha 1}+997^{2} R_{\alpha 0} \Delta \beta_{0}\right) 1000 R_{\kappa 2}+997^{3} R_{\kappa 1} R_{\alpha 0} \Delta^{(3} \beta_{0}\right)}
\end{aligned}
$$
<p style="text-align:right;">3.10-11</p>

Since we are looking for the optimal amount \ $\operatorname{In}\left(\Delta \beta_{0}\right)$, We can make the following simplifications.

$$
\begin{aligned}
\text { let } x &=\Delta \beta_{0} \\
\text { let } C_{A} &=997^{3} R_{\beta 2} R_{\alpha 0} R_{\kappa 1} \\
\text { let } C_{B} &=1000^{3} R_{\beta 0} R_{\alpha 1} R_{\kappa 2} \\
\text { let } C_{C} &=997000000 R_{\alpha 1} R_{\kappa 2} \\
\text { let } C_{D} &=997^{2} 1000 R_{\alpha 0} R_{\kappa 2} \\
\text { let } C_{E} &=997^{3} R_{\kappa 1} R_{\alpha 0}
\end{aligned}
$$

<p style="text-align:right;">3.12-18</p>

Thus equation $3.11$ can be reduced to equation 3.19.


$$
\Delta \beta_{2}=\frac{C_{A} x}{C_{B}+x\left(C_{C}+C_{D}+C_{E}\right)}
$$

<p style="text-align:right;">3.19</p>

Therfore the profit (y), from equation $3.7$ can be expressed in terms of the amount In $( x )$, shown in equation 3.20.


$$
\begin{aligned}
y &=\frac{C_{A} x}{C_{B}+x\left(C_{C}+C_{D}+C_{E}\right)}-x \\
&=\frac{C_{A} x-x\left(C_{B}+x\left(C_{C}+C_{D}+C_{E}\right)\right)}{C_{B}+x\left(C_{C}+C_{D}+C_{E}\right)} \\
&=\frac{x\left(C_{A}-C_{B}\right)-x^{2}\left(C_{C}+C_{D}+C_{E}\right)}{C_{B}+x\left(C_{C}+C_{D}+C_{E}\right)} \\
&=\frac{x C_{F}-x^{2} C_{G}}{C_{B}+x C_{G}}
\end{aligned}
$$

Where:

$$
\begin{aligned}
&C_{F}=C_{A}-C_{B} \\
&C_{G}=C_{C}+C_{D}+C_{E}
\end{aligned}
$$

Maximum profit occurs at a turning point i.e. where the gradient or differential is zero, shown in equation 3.26.

$$
\frac{d y}{d x}=0
$$

Since we have a complex equation for differentiating, we can use the quotient rule from equation 1.9. Numerator and denominator differentials are shown in equations $3.30$ and $3.31$.

$$
\begin{aligned}
\frac{d y}{d x} &=\frac{d \frac{f(x)}{g(x)}}{d x} \\
f(x) &=x C_{F}-x^{2} C_{G} \\
g(x) &=C_{B}+x C_{G} \\
\frac{f(x)}{d x} &=C_{F}-2 x C_{G} \\
\frac{g(x)}{d x} &=C_{G}
\end{aligned}
$$

Combining the quotient rule with equation $3.26$, we get equation $3.32$, which expands to equation 3.33.

$$
\begin{aligned}
f^{\prime} g &=g^{\prime} f \\
\left(C_{F}-2 x C_{G}\right)\left(C_{B}+x C_{G}\right) &=C_{G}\left(x C_{F}-x^{2} C_{G}\right)
\end{aligned}
$$


Equation $3.33$ can be re-arranged to form a generic quadratic equation $3.34$ and so the parameters can be defined for the quadratic solution in equation ??.
$$
x^{2} C_{G}^{2}+x\left(2 C_{B} C_{G}\right)-C_{B} C_{F}=0
$$
Solution to the optimal triangular arbitrage size for a given path is shown in equation 3.35.
$$
x^{*}=\frac{-\left(2 C_{B} C_{G}\right) \pm \sqrt{\left(2 C_{B} C_{G}\right)^{2}-4\left(C_{G}^{2}\right)\left(-C_{B} C_{F}\right)}}{2 C_{G}^{2}}
$$

## 3.2 Improvements


---

[^](/nCeNAQLrTDKs42oLSFgUOg)The editor disputes this fact.
[^2](/0u_9F1NgSUefI3Pp0qH4-Q) From the Latin *consequentem* (nominative consequens) "following, consequent," present participle of consequi "to follow after".  

## Citations

1] Hayden Adams. 2018. url: https://hackmd.io/@477aQ9OrQTCbVR3fq1Qzxg/HJ9jLsfTz?
type=view.
[2] Guillermo Angeris et al. An analysis of Uniswap markets. 2019. arXiv: 1911.03380
[q-fin.TR].

[3] Guillermo Angeris Hsien-Tang Kao, Rei Chiang Charlie Noyes Tarun Chitra (2019).

"*An analysis of Uniswap markets*" In.

[4] Michel, Christoph (2020). "*DeFi Sandwich attacks*". Last accessed: September 2021. url: https://cmichel.io/de-fi-sandwich-attacks/.

Sushiswap (2020). "Sushiswap WBTC-WETH liquidity snapshot". Last accessed: September 2021. url: https://analytics.sushi.com/pairs/0xceff51756c56ceffca006cd410 

Zinsmeister, N., Adams, H., Robinson, D., & Salem, M. (2019). **Uniswap v2-core **(Version 1.0.1) [Computer software]. https://github.com/Uniswap/v2-core

Bacha, S. (2021).** Gas Reporting Index** (Version 1.1.4) [Computer software]. https://doi.org/10.5281/zenodo.1234

Guillermo Angeris, Tarun Chitra (2022). **Optimal Routing for Constant Function Market Makers** [Computer software]. https://github.com/angeris/cfmm-routing-code
