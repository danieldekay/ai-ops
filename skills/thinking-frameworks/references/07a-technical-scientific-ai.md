## Technical, Scientific, AI, and Research Frameworks — Part 1/4

<!-- Frameworks in this file: PAC Learning Framework, VC Dimension Analysis, Bayesian Inference Cycle, Minimum Description Length (MDL), Kolmogorov Complexity Lens, Shannon Channel Capacity, Causal DAG (Do-Calculus), Popperian Falsificationism, Epistemic Humility Ladder, Coherentism vs. Foundationalism Audit -->

### PAC Learning Framework

**Category:** AI/ML — Computational Learning Theory

**Tags:** machine learning theory, sample complexity, generalization, learnability, statistical learning

**How it works:** Probably Approximately Correct (PAC) learning, [introduced by Leslie Valiant in 1984](https://en.wikipedia.org/wiki/Probably_approximately_correct_learning), provides a rigorous mathematical basis for asking when a concept class can be learned from data. A learner is given random samples labeled by an unknown target concept and must output a hypothesis that, with probability at least \(1 - \delta\), achieves error at most \(\epsilon\). The framework forces practitioners to make explicit two tolerance parameters — the approximation error \(\epsilon\) and the confidence failure probability \(\delta\) — as well as to bound both sample complexity and computational complexity as polynomials of the concept size. This separates tractable learning problems from those that are computationally intractable regardless of data volume. PAC analysis underpins generalization bounds in modern ML, informs dataset sizing decisions, and clarifies when a model family is theoretically appropriate for a given task.

**Dimensions / components:**
- **Concept class C:** the set of all target functions the learner could be asked to approximate.
- **Hypothesis class H:** the set of functions the learner is allowed to output (may differ from C).
- **Sample oracle EX(c, D):** the labeled example source drawn i.i.d. from unknown distribution D.
- **Error tolerance ε:** maximum acceptable generalization error for the learned hypothesis.
- **Confidence parameter δ:** acceptable probability that the learner fails to meet ε.
- **Sample complexity m(ε, δ):** minimum examples required to guarantee PAC learnability.
- **Computational efficiency:** requirement that the learning algorithm runs in time polynomial in concept size, 1/ε, and 1/δ.

**Guiding questions:**
- Is the target concept class PAC learnable, or can we prove a hardness lower bound?
- What minimum dataset size does PAC analysis prescribe for our target ε and δ?
- Does our chosen hypothesis class match or exceed the expressiveness of the concept class?
- Are the computational resources required polynomial in the relevant parameters?
- How does distribution shift (D at train ≠ D at deployment) violate the PAC assumptions?
- Is empirical risk minimization (ERM) computationally feasible for this hypothesis class?

**Evaluation criteria:**
- Sample complexity is polynomial in 1/ε, 1/δ, and concept size.
- Learning algorithm halts in polynomial time.
- The framework's distribution-free assumption is realistic for the deployment context.
- Generalization bounds remain tight enough to be practically informative.
- Concept class is clearly defined with a computable representation scheme.

**Typical use cases:**
- Justifying dataset size requirements for a new supervised learning task.
- Comparing hypothesis class complexity across candidate model families.
- Auditing whether published sample complexity guarantees hold for a production ML system.
- Grounding academic ML research proposals in formal learnability theory.
- Diagnosing underfitting by checking whether the hypothesis class is expressive enough.

**Strengths and limitations:** PAC learning provides the cleanest theoretical link between dataset size, model complexity, and generalization — making guarantees explicit rather than empirical. It forces clarity about what a learner is being asked to do. However, PAC bounds are often too loose to be quantitatively useful in practice; real-world distributions are rarely i.i.d., and the distribution-free assumption can be overly pessimistic. Computational PAC-learnability also ignores constants, so polynomial-time algorithms may still be prohibitively slow. The framework is most valuable as a diagnostic lens rather than a design recipe.

**Related frameworks:** VC Dimension Analysis, Bayesian Inference Cycle, Minimum Description Length, Bias–Variance Decomposition, Statistical Power Analysis

---

### VC Dimension Analysis

**Category:** AI/ML — Statistical Learning Theory

**Tags:** model complexity, generalization, shattering, capacity control, hypothesis class

**How it works:** The Vapnik–Chervonenkis (VC) dimension, [developed by Vapnik and Chervonenkis during 1960–1990](https://en.wikipedia.org/wiki/Vapnik%E2%80%93Chervonenkis_theory), quantifies the expressive capacity of a hypothesis class H by measuring the size of the largest set of points that H can "shatter" — assign every possible binary labeling to. A finite VC dimension d implies that the empirical risk of ERM converges uniformly to true risk as data grows, establishing a formal link between complexity and generalization. Sauer's lemma provides polynomial growth bounds on the number of distinct labelings a VC class can produce, which converts combinatorial richness into concrete sample-size prescriptions. Practitioners use VC dimension to compare model families, diagnose overfitting structural causes, and set regularization strategies. It also underlies the theoretical justification for support vector machines and kernel methods.

**Dimensions / components:**
- **Shattering:** a set S is shattered if H can realize every binary labeling of S.
- **VC dimension d:** cardinality of the largest shattered set; infinite VC means no uniform convergence guarantee.
- **Growth function / Sauer's lemma:** bounds the number of dichotomies H induces on n points as \(O(n^d)\).
- **Generalization bound:** relates empirical risk gap to \(\sqrt{d \log n / n}\).
- **Structural Risk Minimization (SRM):** selects models by minimizing empirical risk penalized for VC dimension.
- **Capacity control:** regularization and architecture choices that constrain effective VC dimension.

**Guiding questions:**
- What is the VC dimension of each candidate model family being compared?
- Is the VC dimension finite, guaranteeing uniform convergence and PAC learnability?
- Does the dataset size n satisfy \(n \gg d\) to make generalization bounds non-vacuous?
- Which regularization technique most effectively reduces effective model capacity?
- Does observed test-set error match the magnitude implied by VC-based bounds?
- Are we conflating parameter count with VC dimension (they do not always coincide)?

**Evaluation criteria:**
- VC dimension is computed or bounded for the chosen hypothesis class.
- Dataset size materially exceeds the VC dimension.
- Generalization bounds derived are non-vacuous (tighter than 100% error).
- Architecture choices can be justified by their effect on capacity control.
- Regularization strategy is grounded in VC or related complexity arguments.
- Overfitting diagnosis refers to capacity mismatch, not only data volume.

**Typical use cases:**
- Selecting between neural network architectures on limited data.
- Designing regularization schedules for high-capacity classifiers.
- Formally justifying model complexity choices in high-stakes ML deployments.
- Teaching structural risk minimization as a principled alternative to hold-out tuning.
- Auditing ML systems to check if generalization claims are theoretically founded.

**Strengths and limitations:** VC dimension yields mathematically rigorous capacity control and connects elegantly to PAC theory. It provides architecture-agnostic insights independent of optimization algorithm. The primary weakness is that VC bounds are often extremely loose in practice — modern deep networks have very high VC dimension yet generalize well, a phenomenon the framework does not fully explain. Computing exact VC dimension for complex architectures is often intractable. The framework is most useful as qualitative guidance and for comparing well-understood model families rather than producing tight quantitative predictions.

**Related frameworks:** PAC Learning Framework, Bias–Variance Decomposition, Minimum Description Length, Structural Equation Modeling, Model Calibration & Reliability Diagrams

---

### Bayesian Inference Cycle

**Category:** Statistics / Epistemology

**Tags:** probabilistic reasoning, belief updating, prior, posterior, uncertainty quantification

**How it works:** Bayesian inference treats probability as a degree of rational belief and provides a principled rule for updating beliefs in light of evidence via [Bayes' theorem](https://en.wikipedia.org/wiki/Bayesian_inference): the posterior \(P(\theta \mid D)\) is proportional to the likelihood \(P(D \mid \theta)\) times the prior \(P(\theta)\). The cycle begins with encoding prior knowledge into a probability distribution over hypotheses or parameters, then conditioning on observed data to form the posterior, which becomes the new prior as further data arrives. This sequential updating property makes Bayesian inference natural for streaming data and continual learning. In practice, posteriors are often approximated using Markov Chain Monte Carlo (MCMC), variational inference, or Laplace approximation. The framework forces explicit treatment of uncertainty at every step, producing full predictive distributions rather than point estimates, which supports calibrated decision-making and risk quantification.

**Dimensions / components:**
- **Prior P(θ):** encodes pre-data beliefs, domain knowledge, or regularization intent.
- **Likelihood P(D|θ):** probabilistic model linking parameters to observed data.
- **Posterior P(θ|D):** updated belief distribution after incorporating evidence.
- **Marginal likelihood P(D):** normalizing constant; key for Bayesian model comparison.
- **Posterior predictive P(x̃|D):** distributional forecast integrating over parameter uncertainty.
- **Inference algorithm:** MCMC, variational Bayes, Laplace approximation, or exact conjugate update.
- **Model comparison:** Bayes factors and leave-one-out cross-validation for selecting among models.

**Guiding questions:**
- What prior beliefs about parameters are defensible given domain knowledge?
- How sensitive are posterior conclusions to the choice of prior (prior sensitivity analysis)?
- Does the posterior predictive distribution match observed data (posterior predictive check)?
- Is the marginal likelihood tractable, or does model comparison require approximation?
- What decision or action does the posterior recommend under the specified loss function?
- Are uncertainty estimates well-calibrated against empirical frequencies?

**Evaluation criteria:**
- Priors are explicitly stated and defended, not implicitly assumed.
- Posterior predictive checks confirm the model generates plausible data.
- Inference algorithm has verified convergence diagnostics (R̂, effective sample size).
- Sensitivity to prior choice is analyzed and reported.
- Full posterior uncertainty, not just point estimates, is communicated to decision-makers.

**Typical use cases:**
- Scientific hypothesis testing where sample sizes are small and uncertainty must propagate.
- Continual learning systems updating predictions as new sensor or user data arrives.
- Clinical trial analysis requiring explicit uncertainty quantification for regulatory review.
- Probabilistic forecasting for demand, risk, or reliability under partial information.
- ML hyperparameter optimization via Bayesian optimization.

**Strengths and limitations:** The Bayesian framework is uniquely coherent: it maintains the laws of probability throughout, naturally incorporates prior domain knowledge, and produces calibrated full-uncertainty distributions rather than point estimates. Its sequential updating property aligns naturally with real-world streaming data accumulation. Key limitations include the computational cost of posterior inference, which is often intractable for large or complex models without approximation; sensitivity to prior misspecification; and the practical challenge of communicating full posterior distributions to non-technical stakeholders. Selecting a likelihood model still involves frequentist-style distributional assumptions. Scalability to very high-dimensional parameter spaces remains an active research area.

**Related frameworks:** PAC Learning Framework, Minimum Description Length, Causal DAG, Statistical Power Analysis, Epistemic Humility Ladder

---

### Minimum Description Length (MDL)

**Category:** Statistics / Information Theory / AI/ML

**Tags:** model selection, compression, Occam's razor, overfitting prevention, inductive inference

**How it works:** The Minimum Description Length principle, [formalized by Jorma Rissanen in the 1970s–80s](https://arxiv.org/abs/math/0406077), reframes statistical model selection as a compression problem: the best model is the one that yields the shortest total description of both the model and the data encoded under that model. Formally, MDL selects the model M that minimizes \(L(M) + L(D \mid M)\), where \(L(M)\) is the bit length of the model and \(L(D \mid M)\) is the bit length of data compressed using the model. This operationalizes Occam's razor — simpler models that still explain the data well are preferred. MDL provides an automatic protection against overfitting because adding parameters increases \(L(M)\) while decreasing \(L(D \mid M)\); the optimal trade-off occurs at the model of just the right complexity. It connects information theory, Bayesian model selection (where the prior encodes model complexity), and practical regularization techniques like AIC and BIC.

**Dimensions / components:**
- **Two-part MDL:** separate description of the model and the residuals (classic formulation).
- **Normalized Maximum Likelihood (NML):** single-part, minimax-optimal refined formulation.
- **Model complexity term L(M):** penalizes parameter count and structural richness.
- **Data fit term L(D|M):** measures how concisely the model describes observed data.
- **Stochastic complexity:** the shortest expected description length over all data generated by a model class.
- **Occam factor:** automatic penalty for model complexity analogous to Bayesian model evidence.

**Guiding questions:**
- Does adding a parameter or architectural feature reduce total description length?
- Is the chosen model class rich enough to compress data, yet simple enough to avoid overfitting?
- How does MDL model selection compare with AIC/BIC or cross-validation on this dataset?
- Can the information content of the data justify the complexity of the proposed model?
- What is the effective number of free parameters as measured by stochastic complexity?
- How sensitive is the MDL score to the choice of reference coding scheme?

**Evaluation criteria:**
- Total two-part description length decreases relative to baseline models.
- The selected model is not dominated by a simpler model with comparable data fit.
- MDL criterion is consistent — with infinite data it recovers the true model class.
- The coding scheme used for comparison is clearly specified and applied uniformly.
- MDL results agree with cross-validation or Bayesian evidence on held-out data.

**Typical use cases:**
- Neural architecture search where model size must be justified by performance gain.
- Feature selection in high-dimensional genomic or financial datasets.
- Grammar induction and natural language model comparison.
- Clustering: selecting number of components in mixture models.
- Scientific model comparison across theories with differing parameter counts.

**Strengths and limitations:** MDL's foundation in coding theory makes it theory-grounded and immune to the p-value problems of null hypothesis testing. It selects models that genuinely generalize rather than those that fit training data maximally, providing automatic overfitting protection without requiring a held-out validation set. Weaknesses include computational intractability of exact NML for many practically important model classes, sensitivity to the choice of reference encoder (which must be specified and held constant across comparisons), and difficulty computing stochastic complexity in non-parametric settings. Like BIC, MDL implicitly assumes consistency with respect to the true data-generating mechanism, which may not hold in misspecified or high-dimensional settings.

**Related frameworks:** Kolmogorov Complexity Lens, Shannon Channel Capacity, Bayesian Inference Cycle, Bias–Variance Decomposition, PAC Learning Framework

---

### Kolmogorov Complexity Lens

**Category:** Information Theory / Epistemology / AI/ML

**Tags:** algorithmic complexity, compressibility, randomness, description length, model simplicity

**How it works:** Kolmogorov complexity \(K(x)\) of an object \(x\) is the length of the shortest program on a universal Turing machine that outputs \(x\) and halts, [as developed by Solomonoff, Kolmogorov, and Chaitin in the 1960s](https://en.wikipedia.org/wiki/Algorithmic_information_theory). It provides an objective, machine-independent (up to a constant) measure of the information content or intrinsic complexity of any finite object. A string is algorithmically random if it cannot be compressed — its shortest description is essentially itself. The lens reframes model quality as: does the model plus its residuals compress the data? It grounds Occam's razor formally, underlies MDL, and provides a framework for comparing the explanatory depth of scientific theories. While \(K(x)\) is uncomputable in general, computable approximations (zip, LZ77, arithmetic coding) serve as practical proxies in data engineering and ML auditing contexts.

**Dimensions / components:**
- **Shortest program:** the minimal algorithmic description producing the target object.
- **Universal Turing machine (UTM):** the reference computation model; \(K\) is machine-independent up to additive constant.
- **Algorithmic randomness:** an object is random if \(K(x) \approx |x|\) — incompressible.
- **Logical depth:** computational time to run the shortest program; measures organized complexity.
- **Conditional complexity K(x|y):** information in x not already in y; basis for algorithmic mutual information.
- **Uncomputable nature:** \(K\) is not computable; practical use relies on compressor-based approximations.

**Guiding questions:**
- Can the observed data pattern be described by a shorter program than the data itself?
- Is the proposed model genuinely simpler (lower K) than alternatives, or only fewer parameters?
- What portion of the data's complexity is explained by the model vs. left as algorithmic noise?
- Does the hypothesis have low logical depth — can a short explanation be efficiently computed?
- How does compression ratio under a standard compressor relate to domain-specific model complexity?
- Are two datasets algorithmically similar (low K(x|y)) in a way that supports transfer learning?

**Evaluation criteria:**
- Complexity claims are grounded in compressibility evidence, not just parameter counts.
- Practical compression proxies are selected and applied consistently.
- The chosen model reduces total algorithmic complexity relative to alternatives.
- Logical depth is considered alongside description length for time-complexity evaluation.
- Randomness vs. structure claims are verified with multiple compression schemes.

**Typical use cases:**
- Measuring data redundancy and information density in data quality audits.
- Comparing model explanatory power in scientific theory selection.
- Detecting anomalies as statistically incompressible sequences in time-series data.
- Transfer learning: assessing whether source and target datasets are algorithmically related.
- AI safety research on simplicity priors and Solomonoff induction.

**Strengths and limitations:** Kolmogorov complexity provides the most fundamental definition of information content for individual objects, capturing structure invisible to statistical measures. It is machine-independent up to additive constants and unifies compression, randomness, and learning theory. Its principal limitation is uncomputability — no algorithm can compute \(K(x)\) exactly. Approximations via compression algorithms are practical but domain-sensitive. The additive constant depending on the UTM choice can matter for small objects. The framework is mainly a conceptual and theoretical tool rather than a direct engineering recipe.

**Related frameworks:** Minimum Description Length, Shannon Channel Capacity, Bayesian Inference Cycle, PAC Learning Framework, Epistemic Humility Ladder

---

### Shannon Channel Capacity

**Category:** Information Theory / Data Engineering / Communications

**Tags:** entropy, mutual information, channel capacity, data compression, noise, transmission limits

**How it works:** Claude Shannon's 1948 landmark paper ["A Mathematical Theory of Communication"](https://people.math.harvard.edu/~ctm/home/text/others/shannon/entropy/entropy.pdf) established the theoretical maximum rate at which information can be transmitted reliably over a noisy channel — the channel capacity C. Entropy \(H(X) = -\sum p_i \log_2 p_i\) measures the average uncertainty in a source; the channel capacity is the maximum mutual information \(I(X;Y)\) between channel input and output over all input distributions. Shannon proved both a source coding theorem (data can be compressed to its entropy) and a channel coding theorem (error-free transmission is achievable at any rate below capacity, impossible above it). Applied to data systems, the framework informs storage compression bounds, network throughput limits, encoding scheme comparisons, and feature information extraction in ML. It is also foundational to understanding the limits of any learning or communication system.

**Dimensions / components:**
- **Entropy H(X):** average bits of information per symbol; fundamental lower bound on lossless compression.
- **Conditional entropy H(Y|X):** residual uncertainty in output given input; equivocation due to noise.
- **Mutual information I(X;Y):** information shared between input and output; I(X;Y) = H(X) - H(X|Y).
- **Channel capacity C:** maximum I(X;Y) over all input distributions; measured in bits per channel use.
- **Shannon limit:** rate below which reliable communication is theoretically achievable.
- **Source coding theorem:** lossless compression achieves entropy; no lossless scheme beats it.
- **Channel coding theorem:** channel codes exist achieving rates up to C with arbitrarily low error.

**Guiding questions:**
- What is the entropy of the data source, and what is the theoretical minimum compressed size?
- Is the current data encoding scheme approaching Shannon's compression limit?
- What channel capacity does the communication link or data pipeline have, and are we near it?
- How much mutual information does a feature set carry about the target label?
- Where are information bottlenecks in the data pipeline reducing effective throughput?
- Does a proposed encoding scheme achieve near-optimal error correction given the channel noise model?

**Evaluation criteria:**
- Compression ratios are benchmarked against theoretical entropy-based minimum.
- Communication protocols are analyzed for proximity to calculated channel capacity.
- Mutual information estimates are robust to sample size and distribution assumptions.
- Feature selection criteria reference information gain as a principled measure.
- Pipeline latency and bandwidth are framed as capacity constraints, not just engineering targets.

**Typical use cases:**
- Designing or auditing lossless and lossy compression schemes for large data stores.
- Setting realistic data throughput targets for distributed systems.
- Feature engineering: ranking features by mutual information with target variable.
- Information bottleneck analysis for deep neural network representation learning.
- Telecommunications system capacity planning and error-correcting code design.

**Strengths and limitations:** Shannon's framework is mathematically exact and provides absolute limits against which any practical system can be benchmarked. Mutual information is a powerful model-agnostic measure of statistical dependence. Limitations include the asymptotic nature of capacity theorems (they guarantee existence of good codes but not efficient construction), the difficulty of estimating entropy and mutual information reliably from finite samples, and the idealized noise models that may not match real systems. For ML, information-theoretic quantities often must be approximated using neural estimators, introducing their own biases.

**Related frameworks:** Kolmogorov Complexity Lens, Minimum Description Length, Lambda Architecture, Schema-on-Read vs. Schema-on-Write Decision, Data Mesh

---

### Causal DAG (Do-Calculus)

**Category:** Statistics / Mathematical Modeling / Scientific Research

**Tags:** causal inference, directed acyclic graphs, confounding, interventional distribution, Pearl

**How it works:** Judea Pearl's do-calculus framework, [developed through the 1990s and codified in *Causality* (2000)](https://www.ncbi.nlm.nih.gov/books/NBK126189/), provides a graphical and algebraic language for reasoning about cause and effect beyond statistical association. A causal Directed Acyclic Graph (DAG) encodes qualitative causal assumptions: nodes are variables, directed edges indicate direct causation, and missing edges represent assumed absence of direct influence. The do-operator \(P(Y \mid do(X=x))\) represents the post-intervention distribution — what would happen if we set X to x externally, breaking its natural causes. Pearl's three rules of do-calculus, together with the backdoor and front-door criteria, allow identification of interventional distributions from observational data under stated graphical assumptions. This separates causal questions from mere predictive association, enabling analysis of policy interventions, treatment effects, and mediation without randomized experiments.

**Dimensions / components:**
- **Structural Causal Model (SCM):** functional equations plus a DAG encoding causal mechanisms.
- **Backdoor criterion:** blocks confounding paths by conditioning on a sufficient set of covariates.
- **Front-door criterion:** identifies causal effects through mediator variables when confounders are unobserved.
- **d-separation:** graphical criterion for reading conditional independence from the DAG.
- **Do-operator do(X=x):** represents external intervention — fixes X regardless of its natural causes.
- **Counterfactual queries:** uses SCM to reason about "what would have happened if X had been different."
- **Identifiability:** whether \(P(Y \mid do(X))\) can be computed from observational distribution given the DAG.

**Guiding questions:**
- What causal assumptions are encoded in the DAG, and which are empirically testable?
- Is the target causal effect identifiable from observational data given the assumed DAG?
- Which backdoor adjustment sets suffice to remove confounding?
- Does the DAG reflect domain expert knowledge, or is it derived post hoc from data?
- Can mediation analysis quantify direct vs. indirect effects through a specified pathway?
- What counterfactual conclusions does the SCM support, and what data could falsify them?

**Evaluation criteria:**
- Causal DAG is explicitly stated before analysis and defended with domain arguments.
- d-separation implications are checked against data for consistency.
- Chosen adjustment set satisfies backdoor or front-door criterion, with proof.
- Effect identifiability is verified before estimation rather than assumed.
- Sensitivity analysis explores robustness to unmeasured confounders.

**Typical use cases:**
- Estimating treatment effects from electronic health records without a randomized trial.
- Policy evaluation in economics, epidemiology, or social science.
- Algorithmic fairness analysis: decomposing discriminatory pathways via causal paths.
- Root-cause analysis in ML pipelines when spurious correlations are suspected.
- A/B test design: identifying minimal adjustment sets to improve efficiency.

**Strengths and limitations:** Do-calculus transforms causal reasoning from intuition to formal algebra, enabling rigorous identification proofs and principled sensitivity analysis. It separates model assumptions (the DAG) from statistical estimation, making debates about causality precise. Limitations include the requirement that the DAG be fully specified — in practice, causal structure is rarely known with certainty. The framework assumes no unmeasured confounders in the adjustment sets used, which is often untestable. Continuous high-dimensional settings make exact DAG specification extremely challenging. Estimation after identification still requires careful statistical methods.

**Related frameworks:** Bayesian Inference Cycle, Structural Equation Modeling, Statistical Power Analysis, Popperian Falsificationism, Sensitivity Analysis (Global)

---

### Popperian Falsificationism

**Category:** Epistemology / Scientific Research Methodology

**Tags:** demarcation, testability, hypothesis testing, scientific method, conjecture and refutation

**How it works:** Karl Popper argued in *The Logic of Scientific Discovery* (1934) that scientific theories cannot be confirmed by accumulated positive instances — induction is philosophically untenable — but they can be [falsified](https://en.wikipedia.org/wiki/Falsifiability): a single well-designed counter-instance can conclusively refute a universal claim. The framework distinguishes science from pseudo-science by the demarcation criterion: a theory is scientific if and only if it makes predictions that could, in principle, be empirically refuted. Practice follows a cycle of bold conjectures, severe attempted refutations, and survival of theories that resist refutation (corroboration). Applied to technical work, falsificationism disciplines hypothesis generation, enforces falsifiable success criteria before projects begin, and guards against the confirmation bias of seeking only supporting evidence. A system design is "scientific" in this sense if it specifies failure modes in advance.

**Dimensions / components:**
- **Demarcation criterion:** falsifiability separates scientific from non-scientific claims.
- **Corroboration:** a theory's track record of surviving severe tests; not equivalent to confirmation.
- **Bold conjectures:** theories should make risky, precise, non-trivial predictions.
- **Modus tollens logic:** if T implies P and P is observed false, then T is false.
- **Severity of test:** a good test is one the theory could easily fail if wrong.
- **Fallibilism:** all scientific knowledge is provisional and open to revision.

**Guiding questions:**
- What evidence would falsify the hypothesis, model, or design assumption?
- Are the failure conditions specified before evaluation begins, or only after results are seen?
- How severe is the proposed test — would a false theory be likely to fail it?
- Is the current theory making precise, risky predictions, or only post-hoc explanations?
- Are we seeking disconfirming evidence as rigorously as confirming evidence?
- If the theory survives this test, does corroboration actually increase our confidence?

**Evaluation criteria:**
- Success and failure conditions are specified in advance with observable indicators.
- The test or experiment is capable of producing outcomes that would defeat the hypothesis.
- Negative results are reported and treated as informative rather than suppressed.
- Theories are rejected or revised when falsifying evidence is sufficiently strong.
- Auxiliary assumptions are tracked so that falsifications are attributed correctly.

**Typical use cases:**
- Designing A/B tests with pre-specified null hypotheses and rejection criteria.
- Formulating ML evaluation protocols with defined performance thresholds before model training.
- Auditing research proposals for testability before committing funding or engineering resources.
- Structuring security red-team exercises with falsifiable claims about system resilience.
- Establishing go/no-go criteria in product experiments to prevent post-hoc rationalization.

**Strengths and limitations:** Falsificationism provides a clean, action-guiding norm for rigorous inquiry and directly combats confirmation bias. It aligns with hypothesis-driven engineering and experiment design. Key criticisms (from Kuhn, Lakatos, Duhem-Quine): real science rarely abandons theories on a single falsification — auxiliary hypotheses absorb counterexamples, and research programs persist during anomaly phases. Strict falsificationism cannot accommodate probabilistic or statistical claims cleanly. Lakatos's research programmes and Bayesian confirmation theory offer refinements. Despite these caveats, falsificationism remains the most operationally clear norm for applied technical decision-making.

**Related frameworks:** Bayesian Inference Cycle, Epistemic Humility Ladder, Coherentism vs. Foundationalism Audit, Statistical Power Analysis, Causal DAG

---

### Epistemic Humility Ladder

**Category:** Epistemology / Technical Problem Solving

**Tags:** uncertainty, known unknowns, calibration, meta-cognition, confidence levels

**How it works:** The Epistemic Humility Ladder is a structured framework for mapping the confidence level and completeness of a team's knowledge across the dimensions of a problem. It distinguishes five epistemic states — from known facts with high certainty, through confident working hypotheses, tentative conjectures, known gaps (recognized unknowns), to structural unknowns (unrecognized blind spots). By explicitly classifying each belief or assumption on this ladder before making decisions, teams avoid confusing model outputs for ground truth, prevent overconfident resource allocation, and surface critical gaps early. The framework draws on Rumsfeld's known-unknowns taxonomy, philosophical fallibilism, and calibration research in judgment and decision-making. It is particularly valuable in AI/ML contexts where model confidence scores are often miscalibrated, and in novel engineering domains where entire categories of failure modes may be uncharted.

**Dimensions / components:**
- **Rung 1 — Established facts:** empirically verified, replicated, high-confidence knowledge.
- **Rung 2 — Strong working hypothesis:** consistent with evidence but not exhaustively tested.
- **Rung 3 — Tentative conjecture:** plausible but lacking rigorous empirical support.
- **Rung 4 — Known unknowns:** gaps explicitly identified; data collection or research is needed.
- **Rung 5 — Unknown unknowns:** structural blind spots; require adversarial probing to surface.
- **Calibration check:** comparing stated confidence levels to empirical accuracy frequencies.

**Guiding questions:**
- On which rung of the ladder does each core assumption sit?
- What would it take to promote a tentative conjecture to a strong working hypothesis?
- Are there known unknowns that pose unacceptable decision risk, requiring immediate investigation?
- What adversarial test or perspective might reveal unknown unknowns?
- Are stated model confidence scores empirically calibrated against observed outcome frequencies?
- Is the team's collective epistemic state being communicated accurately to stakeholders?

**Evaluation criteria:**
- Every key assumption is explicitly classified by epistemic status before project kick-off.
- Claims are not treated as established facts unless they meet the evidentiary standard.
- Calibration data (forecast vs. outcome) is tracked over time for recurring decisions.
- Known unknowns have assigned owners and timelines for resolution.
- Decision thresholds are adjusted for the epistemic rung of the supporting evidence.

**Typical use cases:**
- Pre-deployment ML model audits classifying which performance claims are empirically established vs. assumed.
- Strategic technology bets where distinguishing hypothesis from evidence is high-stakes.
- Scientific research proposals assessing knowledge gaps before study design.
- Incident post-mortems identifying which failure modes were known unknowns vs. blind spots.
- Organizational knowledge management and expertise mapping.

**Strengths and limitations:** The ladder makes implicit epistemic status explicit, directly improving decision quality, resource allocation, and communication to stakeholders who may not realize which claims are well-evidenced and which are speculative. It is lightweight enough to integrate into existing project or product review processes without significant overhead. Its core limitation is subjectivity: correctly placing beliefs on the ladder requires metacognitive sophistication and group consensus that may be difficult to sustain under deadline pressure. The "unknown unknowns" rung is by definition hard to act upon — the framework identifies that blind spots exist but provides no guaranteed method for discovering them. It works best when actively paired with adversarial probing techniques such as red teaming.

**Related frameworks:** Popperian Falsificationism, Coherentism vs. Foundationalism Audit, Bayesian Inference Cycle, Model Calibration & Reliability Diagrams, Red Team / Blue Team Adversarial Review

---

### Coherentism vs. Foundationalism Audit

**Category:** Epistemology / Scientific Research

**Tags:** belief justification, epistemic architecture, axioms, circular reasoning, theory evaluation

**How it works:** This framework applies the epistemological debate between foundationalism (beliefs form a hierarchical structure grounded in self-justifying axioms or observation statements) and coherentism (beliefs are justified by their mutual consistency within a web of interdependent beliefs) as a diagnostic audit for knowledge systems, models, or technical architectures. Applied to a data model, ML system, or scientific theory, the audit asks: Are core assumptions justified by axioms that require no further justification (foundationalist), or are they justified only by their coherence with other assumptions (coherentist)? Circular justification in a coherentist system is often invisible without explicit mapping. Foundationalist systems are more auditable but risk resting on contestable axioms. The framework is particularly valuable when evaluating scientific models, ontologies, and system design documents where the justificatory structure is implicit.

**Dimensions / components:**
- **Foundationalist pillar:** identification of basic beliefs or axioms treated as self-evident or empirically basic.
- **Derived belief hierarchy:** mapping which claims depend logically or causally on foundational claims.
- **Coherentist web:** set of beliefs where justification is mutual rather than hierarchical.
- **Circularity detection:** finding closed loops of mutual justification that lack external grounding.
- **Regress audit:** checking whether chains of justification terminate at defensible foundations.
- **Holistic revision:** coherentism's prediction that a web of beliefs is revised jointly, not atomically.

**Guiding questions:**
- What are the foundational axioms or basic assumptions of this system, and are they contestable?
- Is any core belief justified only by reference to other beliefs in the same system (coherentist loop)?
- If a foundational assumption is rejected, which derived claims collapse?
- Does the system present a coherent internal narrative that masks empirical inadequacy?
- Are measurement models or ground-truth labels themselves treated as foundationally secure?
- Has the justificatory structure of this model been externalized and made auditable?

**Evaluation criteria:**
- Core axioms are explicitly identified and distinguished from derived conclusions.
- Circular justification chains are detected and flagged for resolution.
- Each foundational assumption is evaluated for contestability with domain evidence.
- The audit produces a dependency map showing epistemic vulnerability points.
- Revision protocols specify how belief revisions propagate through the justificatory network.

**Typical use cases:**
- Auditing ontologies and knowledge graphs for hidden circular definitions.
- Evaluating ML data labeling pipelines where ground truth is itself a model output.
- Scientific peer review of theoretical frameworks to surface hidden axioms.
- System architecture review to identify which design principles are axioms vs. derived rules.
- Organizational knowledge audits before migrating to new technology paradigms.

**Strengths and limitations:** The audit surfaces invisible epistemic assumptions that standard technical review consistently misses, especially in AI systems where training labels are outputs of prior models — creating coherentist justification loops. It forces teams to separate what is empirically established from what is merely mutually self-consistent. Limitations include requiring philosophical literacy and skilled facilitation to apply rigorously, resistance from practitioners who view epistemological audit as non-technical overhead, and the fact that pure foundationalism and coherentism are both philosophically contested — most real-world knowledge systems are justified hybrids. The framework is diagnostic rather than prescriptive; it identifies circular justification problems without always providing straightforward resolution paths or algorithmic remedies.

**Related frameworks:** Epistemic Humility Ladder, Popperian Falsificationism, Causal DAG, Structural Equation Modeling, Sensitivity Analysis (Global)

---
