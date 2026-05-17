## Decision-Making, Critical Thinking, and Mental Models — Part 7/7

<!-- Frameworks in this file: Structured Analogy, Argument from Analogy, Game Theory (Strategic Interaction Analysis), Devil's Advocacy (Formal Process), Decomposition and Aggregation (Fermi Estimation), Moral Intuition Pumps, Opportunity Space Mapping -->

### Structured Analogy

**Category:** Forecasting / Analytical Reasoning
**Tags:** analogical reasoning, case-based forecasting, historical precedent, comparison
**How it works:** Structured analogy is a judgmental forecasting method in which practitioners deliberately identify one or more historical situations that structurally resemble the current forecasting challenge, extract the outcomes from those historical cases, and use those outcomes as anchors for the current forecast. Unlike informal analogical reasoning—where practitioners unconsciously select the analogy most consistent with their prior beliefs—structured analogy requires explicit articulation of the matching criteria, systematic search for the closest analogues, transparent comparison of similarities and differences, and calibrated adjustment of the historical outcome for known differences. The method was formalized in forecasting research ([Green & Armstrong, 2007](https://doi.org/10.1016/j.ijforecast.2006.05.001)) and is particularly valuable when time-series data is unavailable, but case histories exist. The method is particularly valuable when time-series data is unavailable but comparable case histories provide empirical outcome distributions.

**Dimensions / components:**
- Forecasting target: the outcome to be predicted
- Analogy search: systematic identification of candidate historical cases
- Matching criteria: explicit specification of structural similarities to evaluate
- Similarity rating: scoring candidate analogies on each matching criterion
- Outcome extraction: identifying the actual outcome in the best-matching analogue cases
- Difference adjustment: calibrated modification of the historical outcome for known divergences
- Ensemble averaging: combining forecasts from multiple analogues

**Guiding questions:**
- What historical situations most closely resemble the current challenge?
- On which structural dimensions are the analogues most similar, and on which do they differ?
- What were the actual outcomes in the historical analogue cases?
- How should the forecast be adjusted for the known differences between the analogue and the current case?
- Am I selecting analogies that confirm my prior expectation, or conducting a systematic search?

**Evaluation criteria:**
- Is the analogy search systematic and documented, not purely intuitive?
- Are matching criteria made explicit before selecting analogues?
- Are multiple analogues used and their outcomes averaged?
- Are differences from the analogue explicitly accounted for in the adjustment?
- Is the analogy selection validated by an independent reviewer?

**Typical use cases:**
- New product market entry forecasting
- Geopolitical risk scenario development
- Economic recession forecasting using historical episodes
- Technology adoption curve estimation

**Strengths and limitations:** Structured analogy outperforms expert opinion in controlled forecasting competitions when the method is applied rigorously, because it anchors in empirical base rates rather than expert intuition. The limitation is analogy selection quality: practitioners systematically bias toward familiar, recent, or culturally salient analogies that may not be the best structural matches. The method also fails when the current situation is genuinely without historical precedent. Augmented by systematic analogy search criteria and multi-case averaging, it substantially outperforms unstructured expert opinion in forecasting tournaments.

**Related frameworks:** Reference-Class Forecasting, Analogical Reasoning, Delphi Method, Bayesian Updating, Scenario Analysis

---

### Argument from Analogy

**Category:** Logic and Argumentation
**Tags:** analogical inference, critical evaluation, logical strength, similarity, legal reasoning
**How it works:** Argument from analogy is a form of inductive inference in which a conclusion is supported by demonstrating that the subject shares relevant characteristics with a better-understood case, and that the conclusion follows from those shared characteristics. The logical structure is: Case A and Case B share properties P1, P2, P3; Case A has property Q; therefore, Case B probably has property Q. The strength of an analogical argument depends on: the number of shared properties, the relevance of the shared properties to Q, the absence of relevant disanalogies, and the breadth of the conclusion claimed. Argumentation from analogy is pervasive in legal reasoning (precedent), ethical argument (trolley problems), and scientific hypothesis generation. Critical evaluation requires testing each similarity for relevance, actively seeking disanalogies, and checking whether the analogy supports only the narrow conclusion advanced.

**Dimensions / components:**
- Source case: the better-understood case from which the inference is drawn
- Target case: the case to which the inference is applied
- Shared properties: the characteristics common to both cases
- Conclusion property: the property inferred to apply to the target
- Relevance of similarities: whether shared properties are causally connected to the conclusion
- Disanalogies: respects in which the cases differ, potentially undermining the inference
- Breadth of conclusion: narrow vs. sweeping claims from the analogy

**Guiding questions:**
- What specific properties do the source and target cases share?
- Are the shared properties causally or logically relevant to the conclusion?
- What are the significant differences between the cases, and do any of them undermine the inference?
- Is the conclusion appropriately narrow, or does it overclaim on the basis of partial similarity?
- Is this the strongest available analogy, or has it been selected to confirm a pre-existing conclusion?

**Evaluation criteria:**
- Are shared properties genuinely relevant, not superficially similar?
- Have disanalogies been actively sought and evaluated?
- Is the conclusion strength calibrated to the quality of the analogy?
- Is the analogy valid in both directions, or does it only support the intended inference?
- Has the best available analogy been used, not merely the most convenient?

**Typical use cases:**
- Legal case argumentation and precedent application
- Ethical reasoning about novel situations
- Scientific hypothesis generation
- Policy design informed by international comparisons

**Strengths and limitations:** Argument from analogy is the dominant form of reasoning under novelty—when a situation is unprecedented, analogies to known cases are often the only available inferential resource. In legal and ethical reasoning, analogical argument is institutionally central and often highly rigorous. The limitation is the ease with which superficial similarities can mask fundamental disanalogies, especially when the arguer is motivated to reach a particular conclusion. Every analogy both illuminates and distorts, and the features highlighted by an analogy inevitably suppress others.

**Related frameworks:** Analogical Reasoning, Structured Analogy, Abductive Reasoning, Toulmin Model of Argumentation, Falsificationism

---

### Game Theory (Strategic Interaction Analysis)

**Category:** Analytical Reasoning / Decision-Making
**Tags:** Nash, von Neumann, Morgenstern, equilibrium, strategic, rationality
**How it works:** Game theory is the mathematical study of strategic interaction among rational agents, providing a framework for analyzing decisions where the optimal choice for each actor depends on the choices of other actors. Foundational concepts include: the Nash equilibrium (a strategy profile from which no player has a unilateral incentive to deviate, developed by John Nash in 1950); dominant strategies (choices that are optimal regardless of what others do); the Prisoner's Dilemma (a paradigm case where individually rational choices produce collectively suboptimal outcomes); and repeated games (where cooperation can emerge as an equilibrium when interactions recur). Applied game-theoretic thinking involves identifying players, their strategy sets, their payoffs, and the information available to each, then predicting likely equilibrium outcomes and designing payoff structures to incentivize desired behavior.

**Dimensions / components:**
- Players: the decision-making actors in the strategic situation
- Strategies: the complete set of actions available to each player
- Payoffs: the outcome each player receives for each combination of strategies
- Information structure: what each player knows about others' strategies and payoffs
- Nash equilibrium: the stable strategic outcome prediction
- Dominant strategy: optimal choice independent of others' behavior
- Cooperative vs. non-cooperative games: whether binding agreements are possible

**Guiding questions:**
- Who are all the players, and what strategies are available to each?
- What does each player actually care about (their payoff function)?
- Is there a dominant strategy, or does optimal play depend on what others do?
- What is the Nash equilibrium, and does it lead to a desirable collective outcome?
- Can the payoff structure be redesigned to align individual incentives with collective welfare?

**Evaluation criteria:**
- Are all players and their strategy sets correctly identified?
- Are payoff estimates based on evidence about actual preferences, not assumed?
- Is the Nash equilibrium prediction robust to small perturbations in payoffs?
- Does the analysis capture the information asymmetries between players?
- Are cooperative mechanisms (contracts, commitments) available to overcome Prisoner's Dilemma outcomes?

**Typical use cases:**
- Competitive strategy and auction design
- Contract and incentive mechanism design
- Negotiation analysis and strategic offer sequencing
- Arms control and geopolitical equilibrium analysis

**Strengths and limitations:** Game theory provides the only rigorous framework for analyzing multi-party strategic interactions, and its equilibrium concepts are empirically predictive in many market and negotiation settings. Mechanism design—the reverse engineering of games to produce desired equilibria—is among the most practically powerful analytical tools in economics. The principal limitation is the rationality assumption: real actors have bounded rationality, inconsistent preferences, and social motivations that diverge from payoff maximization, causing Nash equilibrium predictions to fail in many experimental and field contexts. Applied to mechanism design, game theory has produced some of the most economically valuable real-world interventions in auction theory and market design.

**Related frameworks:** Decision Trees, Bayesian Updating, Pre-commitment and Ulysses Contract, Opportunity Cost, Weighted Decision Matrix

---

### Devil's Advocacy (Formal Process)

**Category:** Critical Thinking / Cognitive Debiasing
**Tags:** groupthink, counterargument, structured debate, dissent, decision quality
**How it works:** Devil's Advocacy as a formal organizational process assigns a designated individual or team the explicit role of constructing the strongest possible case against a proposed decision or plan, regardless of their personal view of the proposal. The term derives from the Catholic Church's historical *advocatus diaboli* role in canonization proceedings, where an official was tasked with identifying evidence against sainthood. In organizational decision-making, the devil's advocate role counters groupthink and the confirmation bias that causes teams to seek evidence supporting proposals rather than challenging them. The process is most effective when the advocacy role is explicitly assigned (not self-selected by skeptics), when the advocate is given time and resources to build the case, and when the advocate presents formally before the group makes its final decision—creating a structured adversarial review of the proposal's weaknesses.

**Dimensions / components:**
- Role assignment: explicit designation of the devil's advocate before deliberation
- Case construction: systematic identification of flaws, risks, and counter-evidence
- Formal presentation: structured presentation of the adversarial case
- Group response: proposers must address the counter-case, not dismiss it
- Rotation: different members serve the role across decisions to prevent "designated skeptic" stigma
- Documentation: recording the counter-case and the proposers' responses

**Guiding questions:**
- What is the strongest possible case against this proposal?
- What evidence would refute the key assumptions underlying the plan?
- What scenarios would cause this decision to fail catastrophically?
- Have the proposers fully addressed the counter-case, or deflected it?
- Does assigning the devil's advocate role change the quality of responses compared to organic dissent?

**Evaluation criteria:**
- Is the devil's advocate role explicitly assigned rather than emerging from natural skeptics?
- Is the advocate given adequate preparation time and information?
- Is the counter-case substantive and based on evidence, not reflexive opposition?
- Are proposers required to respond to the counter-case before the decision is finalized?
- Is the process documented as part of the decision record?

**Typical use cases:**
- Strategic acquisition and major investment decisions
- Military and intelligence planning reviews
- Policy development processes
- Scientific peer review and grant evaluation

**Strengths and limitations:** Formal devil's advocacy is among the most empirically validated decision-quality interventions, consistently improving outcomes by surfacing overlooked risks and preventing premature consensus. It is particularly powerful against groupthink and Abilene paradox dynamics. The limitation is that it can become ritualized—a pro forma adversarial presentation that the group has already socially pre-agreed to dismiss—and it may create adversarial rather than collaborative decision cultures if not managed carefully. Organizations that institutionalize formal devil's advocacy as a decision-review requirement report significantly fewer costly strategic errors over time.

**Related frameworks:** Red Team Analysis, Pre-Mortem Analysis, Steel-Manning, Confirmation Bias Debiasing, Six Thinking Hats

---

### Decomposition and Aggregation (Fermi Estimation)

**Category:** Analytical Reasoning / Forecasting
**Tags:** Fermi, estimation, back-of-envelope, quantitative reasoning, uncertainty
**How it works:** Fermi estimation is a problem-solving technique named after physicist Enrico Fermi, who was famous for making rapid, surprisingly accurate order-of-magnitude estimates of complex quantities from first principles and basic known facts. The method involves decomposing an unknown quantity into a product of simpler sub-quantities that can each be estimated from available knowledge, then aggregating those estimates to compute the final answer. Classic Fermi questions include: "How many piano tuners are in Chicago?" decomposed into population × households × fraction owning pianos × tuning frequency × tuning time × working hours. The technique is powerful because errors in individual component estimates tend to partially cancel across the decomposition, and the decomposition itself forces the estimator to make their assumptions explicit and challengeable. Superforecasters systematically use Fermi decomposition as a first step in quantitative forecast generation.

**Dimensions / components:**
- Target quantity: the unknown value to be estimated
- Decomposition: expressing the target as a product or sum of knowable sub-quantities
- Component estimation: applying available knowledge to estimate each sub-quantity
- Unit tracking: ensuring dimensional consistency across the decomposition
- Aggregation: computing the final estimate from component estimates
- Range estimation: producing a confidence interval around the central estimate
- Sensitivity check: identifying which component estimates drive the final answer

**Guiding questions:**
- Can this unknown quantity be expressed as a product of simpler quantities?
- What do I actually know that constrains each component estimate?
- What are the units, and are they consistent throughout the decomposition?
- Which component estimate is most uncertain, and does that drive the range?
- Would an alternative decomposition path produce a substantially different answer?

**Evaluation criteria:**
- Is the decomposition logically valid—does the product actually equal the target quantity?
- Are component estimates grounded in known data rather than pure speculation?
- Is dimensional consistency maintained?
- Is a range (not just a point estimate) produced?
- Are the most uncertain components identified for sensitivity analysis?

**Typical use cases:**
- Market sizing and business planning
- Scientific order-of-magnitude reasoning
- Consulting case interviews and rapid strategic assessment
- Resource planning in the absence of detailed data

**Strengths and limitations:** Fermi estimation is one of the most universally applicable analytical skills, enabling quantitative reasoning in data-sparse environments where formal analysis is impossible. The decomposition process forces explicit assumption-making and creates a basis for collaborative challenge and refinement. The limitation is that geometric error compounding—if each of ten components is off by a factor of two, the aggregate can be off by a factor of 1,024—can produce large errors despite the partial-cancellation effect. The method requires honest, non-motivated component estimation to be reliable.

**Related frameworks:** Probabilistic Thinking, Monte Carlo Simulation, Reference-Class Forecasting, Sensitivity Analysis, Superforecasting Method

---

### Moral Intuition Pumps

**Category:** Critical Thinking / Analytical Reasoning
**Tags:** Dennett, Rawls, thought experiments, ethics, decision intuition
**How it works:** Intuition pumps, a term coined by philosopher Daniel Dennett in *Elbow Room* (1984) and expanded in *Intuition Pumps and Other Tools for Thinking* ([Dennett, 2013](https://wwnorton.com/books/intuition-pumps-and-other-tools-for-thinking/)), are carefully constructed thought experiments designed to generate or probe moral and philosophical intuitions. In ethical decision-making contexts, classic intuition pumps—the Trolley Problem, the Violinist (Thomson), the Original Position and Veil of Ignorance (Rawls)—help practitioners clarify their values by presenting scenarios stripped of confounding factors. The Trolley Problem isolates the question of whether actively causing harm to save more lives is morally equivalent to passive harm-allowance. The Veil of Ignorance asks what principles of justice a rational person would choose if they did not know their position in society. Intuition pumps do not resolve ethical dilemmas but reveal the structure of the underlying moral commitments.

**Dimensions / components:**
- Scenario construction: a simplified, stylized case isolating a single moral variable
- Intuition elicitation: identifying the decision-maker's immediate moral response
- Variable manipulation: changing one feature to identify what drives the intuition
- Intuition testing: checking whether the intuition survives reflection or reveals inconsistency
- Principle extraction: articulating the general moral principle the intuition implies
- Cross-case consistency: testing whether the principle produces acceptable outcomes in other cases
- Reflective equilibrium: iteratively adjusting principles and intuitions toward coherence

**Guiding questions:**
- What is my immediate moral intuition about this scenario?
- What changes in the scenario would change my intuition, and why?
- What general principle does my intuition imply?
- Does that principle produce acceptable outcomes in other cases?
- Is my intuition consistent across structurally similar scenarios with different surface features?

**Evaluation criteria:**
- Is the thought experiment properly controlled—does it isolate one moral variable?
- Is the intuition genuinely spontaneous, or is it rationalized after the fact?
- Has the practitioner tested the intuition against alternative scenario framings?
- Does the extracted principle produce consistent, defensible outcomes across cases?
- Has reflective equilibrium been sought—are principles and intuitions mutually adjusted?

**Typical use cases:**
- Ethical decision-making in medical, legal, and policy contexts
- AI ethics and technology governance deliberation
- Philosophical training in moral reasoning
- Leadership ethics and organizational value clarification

**Strengths and limitations:** Intuition pumps are invaluable for surfacing implicit moral commitments that determine decisions but are rarely articulated. The Veil of Ignorance in particular is empirically associated with more impartial and socially defensible policy judgments. The limitation is that the pumping action can be manipulative rather than clarifying: poorly constructed thought experiments can generate intuitions that are artifacts of the scenario's framing rather than genuine moral insights, and skilled rhetoricians can use intuition pumps to lead interlocutors to predetermined conclusions. When used with methodological care—testing intuitions against multiple framings—they are invaluable tools for clarifying ethical commitments.

**Related frameworks:** Socratic Method, Steel-Manning, Framing Effect Debiasing, Scenario Analysis, Devil's Advocate Technique

---

### Opportunity Space Mapping

**Category:** Analytical Reasoning / Decision-Making
**Tags:** market opportunity, Jobs-to-Be-Done, gap analysis, strategic positioning, user needs
**How it works:** Opportunity Space Mapping, formalized in product strategy by Tony Ulwick's outcome-driven innovation methodology ([Ulwick, *Jobs to Be Done*, 2016](https://www.amazon.com/Jobs-Be-Done-New-Theory/dp/0990576744)) and related to Clayton Christensen's Jobs-to-Be-Done framework, is a structured approach to identifying underserved needs in a market by quantifying the importance and satisfaction of customer outcomes. The opportunity score formula—Opportunity = Importance + (Importance − Satisfaction)—identifies outcomes that customers rate as highly important but currently poorly satisfied. These high-opportunity areas represent the strategic "white space" where new offerings can deliver disproportionate value. The mapping process involves comprehensive outcome identification through customer research, importance and satisfaction scoring across a representative sample, computation of opportunity scores, and prioritization of product or service investments around the highest-scoring outcomes. Prioritization targets the highest-opportunity scores, directly aligning investment with the outcomes customers value most but receive least.

**Dimensions / components:**
- Outcome identification: the full set of customer jobs, needs, and desired outcomes
- Importance rating: how important is each outcome to the customer (1–10)?
- Satisfaction rating: how well are current solutions satisfying each outcome (1–10)?
- Opportunity score: Importance + (Importance − Satisfaction)
- Overserved vs. underserved identification: low opportunity (satisfied) vs. high opportunity (unmet)
- Strategic prioritization: investing in highest-opportunity outcomes
- Segment differentiation: different opportunity maps for different customer segments

**Guiding questions:**
- What are all the outcomes customers are trying to achieve in this domain?
- Which outcomes do customers rate as highly important but poorly satisfied?
- Are there outcomes that are overserved—where reducing scope could lower cost without reducing value?
- Do different customer segments have systematically different opportunity maps?
- Are we currently investing in high-opportunity or low-opportunity outcomes?

**Evaluation criteria:**
- Are outcome statements framed in customer language, not product feature language?
- Is the sample representative of the target customer population?
- Are importance and satisfaction ratings independent (not correlated with product familiarity)?
- Are the highest-opportunity outcomes actionable with feasible product investments?
- Is the opportunity map updated as market conditions and customer expectations evolve?

**Typical use cases:**
- New product concept generation and validation
- Product portfolio strategy and investment allocation
- Service design and customer experience improvement
- Market entry and competitive positioning analysis

**Strengths and limitations:** Opportunity Space Mapping provides a rigorous, customer-grounded alternative to intuition-based or competitor-reactive product strategy. By quantifying unmet need, it directly targets where value can be created rather than where features are already clustered. The limitation is research intensity: comprehensive outcome identification and statistically valid importance/satisfaction scoring require substantial investment, and the method can over-index on articulated needs at the expense of latent or emergent needs that customers cannot yet express. When combined with quantitative customer research, it is among the most reliable frameworks for identifying where product investment will create durable competitive advantage.

**Related frameworks:** Jobs-to-Be-Done Framework, Kano Model, RICE Scoring Model, SWOT Analysis, Value vs. Effort Matrix
