## Decision-Making, Critical Thinking, and Mental Models — Part 5/7

<!-- Frameworks in this file: RICE Scoring Model, Kano Model, ICE Scoring Model, Cost-Benefit Analysis, Theory of Constraints, Causal Loop Diagramming, EAST Framework, Double-Loop Learning, Analogical Reasoning, Sensitivity Analysis, Abductive Reasoning, Pre-commitment and Ulysses Contract -->

### RICE Scoring Model

**Category:** Prioritization
**Tags:** product management, quantitative, Intercom, reach, impact, confidence, effort
**How it works:** The RICE scoring model was developed by the product team at Intercom as a quantitative prioritization framework that combats personal bias in feature selection. RICE stands for Reach (how many users will this affect per time period?), Impact (how significantly will it affect each user, scored 0.25 to 3), Confidence (how certain are we of reach and impact estimates, expressed as a percentage), and Effort (person-months of work required). The RICE score is calculated as: (Reach × Impact × Confidence) / Effort. Higher scores indicate higher priority. By making the prioritization calculation explicit and standardized, RICE reduces the influence of the loudest voice, the most recent request, and individual product manager intuition in backlog decisions. ([Intercom's original RICE framework](https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/)) The formula makes trade-offs visible and auditable. ([Original RICE framework](https://www.intercom.com/blog/rice-simple-prioritization-for-product-managers/))

**Dimensions / components:**
- Reach: number of users affected within a defined time period
- Impact: magnitude of effect per user (standardized scale, e.g., 0.25 to 3)
- Confidence: percentage certainty in reach and impact estimates
- Effort: estimated person-months of work required
- RICE score: (Reach × Impact × Confidence) / Effort
- Sensitivity analysis: checking how robust rankings are to estimate changes

**Guiding questions:**
- How many users will realistically be affected by this feature within the measurement period?
- For each user affected, how significantly will this change their experience?
- How confident are we in our reach and impact estimates—are they validated by data?
- What is our realistic effort estimate for shipping this feature end-to-end?
- Is the RICE score ranking consistent with our intuitions, and where it diverges, who is right?

**Evaluation criteria:**
- Are reach estimates based on actual user data rather than aspirational figures?
- Is the impact scale applied consistently across all features being compared?
- Does the confidence percentage accurately reflect data quality and assumption reliability?
- Is the effort estimate inclusive of design, testing, and deployment, not just development?
- Are RICE scores recalculated when estimates change significantly?

**Typical use cases:**
- Product backlog prioritization in agile teams
- Feature investment decisions in B2B and B2C software products
- Quarterly planning and OKR-aligned roadmap construction
- Cross-team initiative prioritization

**Strengths and limitations:** RICE provides a quantitative, reproducible prioritization score that reduces the influence of individual bias and stakeholder loudness, which is a genuine improvement over informal processes. The confidence factor is a particularly thoughtful inclusion, penalizing poorly-validated estimates. Its limitation is that inputs are still subjective: reach and impact estimates can be gamed or anchored on aspirational rather than realistic figures. The formula also treats its four variables as equally weighted and assumes a simple multiplicative relationship that may not hold in all contexts.

**Related frameworks:** Weighted Decision Matrix, MoSCoW Method, Kano Model, Eisenhower Matrix, Cost of Delay

---

### Kano Model

**Category:** Prioritization
**Tags:** customer satisfaction, Kano, feature categorization, delighters, must-be, product
**How it works:** The Kano Model, developed by Professor Noriaki Kano of Tokyo Rika University in the 1980s, classifies product features and attributes by their relationship to customer satisfaction. The model distinguishes five categories: Must-Be (basic expectations whose absence causes extreme dissatisfaction but whose presence is taken for granted); Performance (attributes where more is better—linearly linked to satisfaction); Attractive (delighters that are unexpected and generate disproportionate satisfaction when present, no dissatisfaction when absent); Indifferent (features that generate neither satisfaction nor dissatisfaction regardless of presence); and Reverse (attributes that some customers prefer absent). Customer surveys use paired functional and dysfunctional questions to classify each attribute. ([Kano's original work described in Journal of the Japanese Society for Quality Control, 1984](https://www.tandfonline.com/doi/abs/10.1080/21681015.1984.11346865)) Kano published the foundational framework in 1984. ([Society for Quality Control, 1984](https://www.tandfonline.com/doi/abs/10.1080/21681015.1984.11540845))

**Dimensions / components:**
- Must-Be (Basic): threshold requirements; absence causes dissatisfaction
- Performance (One-Dimensional): linear satisfaction relationship; more is better
- Attractive (Exciting): unexpected features causing disproportionate delight
- Indifferent: neither missed nor appreciated
- Reverse: preferred absent by some customer segments
- Kano survey instrument: paired functional/dysfunctional question format

**Guiding questions:**
- Which features do customers simply expect without noticing, but whose absence would cause complaints?
- Which features generate increasing satisfaction the more they are enhanced?
- Which features would genuinely surprise and delight customers because they are unexpected?
- Are there features we are investing in that customers are genuinely indifferent to?
- Do different customer segments have different Kano classifications for the same feature?

**Evaluation criteria:**
- Is the Kano survey instrument properly applied with functional and dysfunctional question pairs?
- Are features categorized based on customer data rather than internal assumption?
- Does prioritization ensure Must-Be features are fully met before investing in Attractive ones?
- Are Indifferent features explicitly deprioritized to free resources for higher-impact investments?
- Is Kano analysis updated as market expectations evolve (Attractive features become Must-Be over time)?

**Typical use cases:**
- Product feature prioritization and roadmap planning
- Customer satisfaction research and insight
- Service design and customer experience improvement
- New product concept evaluation and selection

**Strengths and limitations:** The Kano Model provides a customer-centric framework for feature prioritization that captures a non-linear, multi-dimensional relationship between features and satisfaction that simpler scoring models miss. The distinction between Must-Be and Attractive features is particularly actionable: it prevents the over-investment in delighters at the expense of unmet basic expectations, and vice versa. Its limitation is that the survey methodology is time-consuming and requires a large, representative sample, making it impractical for rapid iteration cycles. The model also requires updating as customer expectations shift over time.

**Related frameworks:** RICE Scoring Model, MoSCoW Method, Jobs-to-be-Done Framework, Weighted Decision Matrix, Customer Value Mapping

---

### ICE Scoring Model

**Category:** Prioritization
**Tags:** growth hacking, startup, Sean Ellis, impact, confidence, ease, experimentation
**How it works:** The ICE scoring model was popularized by growth hacker Sean Ellis as a lightweight alternative to RICE for rapidly prioritizing growth experiments and marketing hypotheses. ICE stands for Impact (how much will this initiative move the target metric?), Confidence (how confident are we that it will work?), and Ease (how easy is this to implement?). Each dimension is scored on a 1–10 scale, and the ICE score is the average: (Impact + Confidence + Ease) / 3. The simplicity of ICE—three equally weighted dimensions averaged—makes it extremely fast to apply across large idea backlogs, suitable for high-velocity experimentation environments where rough prioritization enables speed. It is explicitly a heuristic rather than a rigorous model and is best suited for environments where the cost of analysis exceeds the cost of a wrong prioritization.

**Dimensions / components:**
- Impact: estimated magnitude of effect on the primary target metric (1–10)
- Confidence: certainty that the initiative will produce the estimated impact (1–10)
- Ease: inverse of effort—how easy and fast to implement (1–10)
- ICE score: (Impact + Confidence + Ease) / 3
- Backlog volume: ICE is most efficient for scoring dozens of ideas rapidly
- Iteration: re-scoring as new evidence updates confidence estimates

**Guiding questions:**
- How significantly will this move the primary metric we care about?
- Based on prior evidence or analogous experiments, how confident are we this will work?
- How quickly and easily can this be implemented with available resources?
- Does this ICE score reflect genuine assessment or wishful thinking on the Impact dimension?
- Have we validated our Confidence score against any direct evidence?

**Evaluation criteria:**
- Are scores based on evidence and prior experiments where available?
- Is the Impact score linked to a specific, measurable metric rather than a vague benefit?
- Is Ease scored accurately, including design, testing, and deployment overhead?
- Is the ICE score used as a rough triage rather than a precise ranking?
- Are the highest-scoring ideas validated with lightweight experiments before full commitment?

**Typical use cases:**
- Growth experiment backlog prioritization in startup and scale-up environments
- Marketing campaign idea triage
- Rapid product iteration in high-velocity teams
- Hypothesis backlog management in experimentation programs

**Strengths and limitations:** ICE is fast, simple, and sufficient for high-volume, low-stakes prioritization decisions where rough sorting is more valuable than precise ranking. Its equal weighting of Impact, Confidence, and Ease prevents the over-indexing on effort that plagues simpler frameworks and makes the confidence dimension explicit, which is often overlooked. Its limitation is precisely its simplicity: equal weighting is not always appropriate, and the model does not account for strategic alignment, regulatory constraints, or interdependencies between initiatives. It should be supplemented by strategic filters in more complex organizational environments.

**Related frameworks:** RICE Scoring Model, Weighted Decision Matrix, Eisenhower Matrix, MoSCoW Method, A/B Testing Framework

---

### Cost-Benefit Analysis

**Category:** Prioritization / Analytical Reasoning
**Tags:** economic evaluation, net present value, public policy, trade-offs, welfare
**How it works:** Cost-benefit analysis (CBA) is a systematic method for evaluating the total expected costs and benefits of a decision, policy, or project to determine whether the net value is positive and to compare alternatives on a common monetary scale. CBA requires: identifying all relevant costs and benefits (direct, indirect, and opportunity costs; tangible and intangible), monetizing each where possible (including shadow pricing for non-market values such as environmental quality or lives), discounting future flows to present value using an appropriate discount rate, and computing net present value (NPV) or benefit-cost ratio. CBA has deep roots in welfare economics and has been a required tool in U.S. federal regulatory analysis since Executive Order 12291 (Reagan, 1981). Its application ranges from infrastructure evaluation to environmental regulation to healthcare technology assessment.

**Dimensions / components:**
- Cost identification: all resource expenditures, including opportunity costs
- Benefit identification: all gains, including non-market and indirect benefits
- Monetization: converting non-financial costs and benefits to monetary equivalents
- Discounting: applying a discount rate to future cash flows
- Net Present Value (NPV): total discounted benefits minus total discounted costs
- Sensitivity analysis: testing NPV under variations in key assumptions
- Distributional analysis: identifying who bears costs and who receives benefits

**Guiding questions:**
- Have all relevant costs and benefits been identified, including indirect and non-market ones?
- What discount rate should be used, and how sensitive is the NPV to that choice?
- How have intangible benefits (lives, ecosystem services, time savings) been monetized?
- Who bears the costs and who receives the benefits, and does the distributional impact matter?
- Under what range of assumptions does this project remain NPV-positive?

**Evaluation criteria:**
- Are all material costs and benefits included, not only the financially obvious ones?
- Is the monetization methodology for non-market values defensible and documented?
- Is the discount rate appropriate to the project's nature and the regulatory context?
- Is sensitivity analysis conducted on the most uncertain and consequential assumptions?
- Is the distributional analysis transparent alongside the aggregate NPV?

**Typical use cases:**
- Government infrastructure and public policy evaluation
- Healthcare technology assessment
- Environmental regulation and conservation policy
- Corporate capital investment decisions

**Strengths and limitations:** CBA provides a principled, monetarily unified framework for comparing options across dimensions, enabling decisions that would otherwise be paralyzed by incommensurable trade-offs. Its requirement to make all assumptions explicit and to monetize intangibles forces precision that informal analysis lacks. Its limitations are significant: the monetization of non-market values (lives, ecosystems, justice) is deeply contested; discount rates for long-horizon projects are philosophically controversial; and CBA is structurally blind to distributional concerns unless explicitly supplemented. Political pressure can also distort input assumptions to rationalize predetermined conclusions.

**Related frameworks:** Expected Value Calculation, Weighted Decision Matrix, Opportunity Cost Analysis, Net Present Value, Multi-Criteria Decision Analysis

---

### Theory of Constraints

**Category:** Analytical Reasoning
**Tags:** Goldratt, bottleneck, systems, throughput, process optimization
**How it works:** The Theory of Constraints (TOC), developed by Eliyahu Goldratt and introduced in "The Goal" (1984), is a management philosophy and analytical framework based on the principle that any system has exactly one constraint (the weakest link) that determines its maximum throughput, and that improvements anywhere other than the constraint produce no increase in system output. The five focusing steps of TOC are: (1) Identify the system's constraint; (2) Exploit the constraint—maximize its utilization; (3) Subordinate everything else to the constraint—optimize the system around the bottleneck; (4) Elevate the constraint—if still binding, add capacity; (5) Return to step 1 (the constraint has moved). TOC produces counterintuitive prescriptions: reducing inventory and efficiency of non-constraint resources to maximize constraint throughput rather than optimizing every resource independently. ([Goldratt Institute](https://www.tocinstitute.org/))

**Dimensions / components:**
- Constraint identification: finding the single binding bottleneck in the system
- Exploitation: maximizing use of constraint capacity without new investment
- Subordination: adjusting all non-constraints to feed the constraint optimally
- Elevation: adding capacity to the constraint when exploitation is insufficient
- System throughput: the rate at which the system generates goal-relevant output
- Constraint migration: tracking where the constraint moves after elevation

**Guiding questions:**
- What is the single step in this process that limits total throughput?
- Are we fully exploiting the constraint's capacity before adding resources elsewhere?
- Are we inadvertently reducing constraint throughput by optimizing non-constraints?
- What would happen to total system throughput if the constraint were removed?
- After we improve the constraint, where does the bottleneck migrate?

**Evaluation criteria:**
- Has the constraint been identified empirically rather than assumed?
- Are non-constraint resources being managed to maximize constraint utilization?
- Are efficiency improvements at non-constraints explicitly rejected unless they move the constraint?
- Is throughput (system-level output) used as the primary performance measure, not local efficiency?
- Is the five-step cycle being repeated as constraints migrate?

**Typical use cases:**
- Manufacturing throughput optimization
- Software development team velocity improvement
- Healthcare patient flow and capacity management
- Supply chain bottleneck identification and relief

**Strengths and limitations:** TOC is one of the most practically powerful operational improvement frameworks available, with documented throughput increases of 20-100% in manufacturing and healthcare settings. Its central insight—that local efficiency improvements outside the constraint produce no system benefit—is counterintuitive and regularly violated in practice, making TOC's prescriptions continuously relevant. Its limitation is that it assumes a single binding constraint at any time, which may not hold in highly parallel systems with multiple near-binding constraints. It also requires accurate throughput measurement, which is challenging in service and knowledge-work environments.

**Related frameworks:** Lean Manufacturing, Systems Thinking, Leverage Points (Meadows), Critical Path Method, Process Flow Analysis

---

### Causal Loop Diagramming

**Category:** Analytical Reasoning
**Tags:** systems dynamics, feedback, Forrester, Senge, dynamic complexity
**How it works:** Causal loop diagramming (CLD) is a qualitative modeling technique used in systems dynamics—developed by Jay Forrester at MIT and popularized by Peter Senge in "The Fifth Discipline" (1990)—to map the feedback structure of a complex system. A CLD consists of variables (nodes) connected by arrows indicating causal relationships, each labeled with a polarity: a positive (+) link means that an increase in the cause produces an increase in the effect (all else equal); a negative (–) link means the opposite. Loops formed by connected variables are classified as reinforcing (R)—positive feedback loops that amplify change—or balancing (B)—negative feedback loops that stabilize the system. CLDs reveal the behavioral consequences of feedback structure: why systems oscillate, why they resist intervention, why they produce delays, and why quick fixes sometimes make problems worse before triggering compensating dynamics. ([MIT Sloan School, Systems Dynamics](https://mitsloan.mit.edu/faculty/research-areas/system-dynamics))

**Dimensions / components:**
- Variables: the factors whose quantities change over time
- Causal links: directional arrows with positive or negative polarity
- Reinforcing loops (R): positive feedback amplifying change in one direction
- Balancing loops (B): negative feedback resisting change and seeking equilibrium
- Delays: time lags in causal relationships that produce oscillation
- Archetypes: recurring feedback structures with predictable behavioral signatures

**Guiding questions:**
- What are the key variables changing in this system, and what drives their change?
- Which reinforcing loops are generating problematic growth or collapse?
- Which balancing loops are resisting my intended change?
- Where are the significant delays that are causing overshoot or oscillation?
- Are there high-leverage interventions that would break a problematic feedback structure?

**Evaluation criteria:**
- Does the CLD include all major reinforcing and balancing loops affecting the key variables?
- Are polarities assigned correctly based on empirical relationships?
- Are significant delays identified and labeled?
- Does the CLD produce behavioral hypotheses that can be tested against historical data?
- Are intervention points linked to feedback structure analysis rather than to variable-level intuition?

**Typical use cases:**
- Organizational growth and decline dynamics analysis
- Environmental and ecological system modeling
- Public health epidemic and policy modeling
- Supply chain inventory and ordering dynamics

**Strengths and limitations:** Causal loop diagramming is the most accessible entry point to systems dynamics modeling and reliably reveals counterintuitive system behaviors that variable-level analysis misses. The discipline of mapping feedback structure consistently surfaces the systemic causes of persistent problems that linear thinking cannot diagnose. Its limitation is qualitative ambiguity: CLDs show the direction but not the magnitude of causal relationships, making quantitative predictions impossible without conversion to stock-and-flow simulation models. They are also easy to build incorrectly—incorrect polarities or missing loops produce deeply misleading diagrams.

**Related frameworks:** Systems Thinking, Leverage Points (Meadows), Theory of Constraints, Scenario Analysis, System Archetypes (Senge)

---

### EAST Framework

**Category:** Analytical Reasoning / Decision-Making
**Tags:** behavioral design, nudge, Behavioral Insights Team, policy, public behavior
**How it works:** The EAST framework was developed by the Behavioural Insights Team (BIT) in the United Kingdom as a practical mnemonic for designing behavior-change interventions that are Easy, Attractive, Social, and Timely. The framework distills complex behavioral science insights into four actionable design principles for policymakers, organizational designers, and product teams. Easy: reduce friction and simplify the desired behavior, as cognitive effort is a powerful behavioral barrier. Attractive: capture attention with incentives, personalization, or salience, since people act on what they notice. Social: leverage social proof and norms, since behavior is powerfully shaped by what people believe others do and what others approve of. Timely: intervene at moments when people are most receptive and when the behavior change aligns with natural decision points. ([The Behavioural Insights Team](https://www.behaviouralinsights.co.uk/); [The Decision Lab's EAST reference](https://thedecisionlab.com/reference-guide/management/east-framework))

**Dimensions / components:**
- Easy: reduce friction, simplify choice, use defaults to the desired behavior
- Attractive: use salient cues, personalization, and incentives to capture attention
- Social: activate social norms, social proof, and peer networks to shape behavior
- Timely: deliver interventions at the most receptive moment in the behavioral cycle
- Behavioral diagnosis: identifying which EAST dimension is the binding constraint
- Evaluation: measuring behavior change against counterfactual baselines

**Guiding questions:**
- What is the primary barrier preventing the desired behavior—friction, inattention, social norms, or timing?
- How can defaults be designed to make the desired behavior the path of least resistance?
- What attention-capturing mechanism would make the desired behavior more salient?
- What social proof or social norms can be invoked to activate the desired behavior?
- At what moment in the natural behavioral cycle is the person most receptive to the intervention?

**Evaluation criteria:**
- Has the primary EAST bottleneck been identified through behavioral diagnosis?
- Are multiple EAST dimensions addressed simultaneously where appropriate?
- Is the intervention evaluated against a control condition to establish causal impact?
- Does the intervention preserve individual autonomy rather than manipulate without transparency?
- Is the behavior change measured at the level of actual behavior (not intentions or attitudes)?

**Typical use cases:**
- Public health intervention design (vaccination, screening, healthy eating)
- Tax compliance and financial behavior change
- Energy conservation program design
- Organizational HR and benefits enrollment improvement

**Strengths and limitations:** The EAST framework is one of the most operationally useful outputs of behavioral science for practitioners who need practical design guidance rather than academic theory. Its four principles cover the most consistently evidence-based behavioral levers available, and the BIT has accumulated extensive RCT evidence supporting their effectiveness across dozens of policy domains. Its limitation is that it is diagnostic but not generative: knowing that an intervention should be "Easy" does not specify what to do. Practitioners need domain knowledge and behavioral expertise to translate EAST principles into specific design choices. The framework also addresses proximate behavioral barriers without addressing deeper structural ones.

**Related frameworks:** Nudge Theory, Dual Process Theory, Behavioral Economics, Choice Architecture, Framing Effect Design

---

### Double-Loop Learning

**Category:** Analytical Reasoning / Mental Models
**Tags:** Argyris, Schön, organizational learning, assumption revision, adaptability
**How it works:** Double-loop learning, developed by Chris Argyris and Donald Schön in "Organizational Learning" (1978), distinguishes between two levels of organizational and individual learning. Single-loop learning detects and corrects errors within an existing set of governing values and assumptions—the organization improves its performance at achieving its current goals. Double-loop learning also questions and modifies the underlying governing values, assumptions, and goals themselves when errors suggest that the current framework is inappropriate. Single-loop learning is operationally necessary and appropriate for routine adjustments. Double-loop learning is required when single-loop corrections keep failing because the problem is in the framework rather than the execution. Argyris argued that most organizations remain stuck in single-loop learning due to defensive reasoning—the tendency to protect established beliefs and avoid threatening information. ([Argyris and Schön's framework, Harvard and MIT](https://www.hbs.edu/faculty/Pages/profile.aspx?facId=12235))

**Dimensions / components:**
- Single-loop learning: detect error → correct action → improve performance within current assumptions
- Double-loop learning: detect error → question assumptions → revise governing values → redesign action
- Governing values: the implicit assumptions and goals driving current behavior
- Defensive reasoning: mechanisms that protect governing values from examination
- Model I behavior: competitive, win-focused, defensive (inhibits double-loop learning)
- Model II behavior: collaborative, inquiry-based, transparent (enables double-loop learning)

**Guiding questions:**
- Is the current problem caused by poor execution within the right framework, or by using the wrong framework?
- What governing assumptions are so embedded that they are never questioned?
- Are the repeated failures in this domain actually signals that the strategy framework itself is wrong?
- What defensive reasoning is preventing the organization from examining its governing values?
- If the underlying assumption I am making were wrong, what would I expect to observe?

**Evaluation criteria:**
- Has the distinction between single-loop and double-loop learning problems been made explicitly?
- Are governing values and assumptions explicitly surfaced and examined rather than left implicit?
- Is there a process for translating double-loop learning into genuine assumption revision?
- Are defensive reasoning mechanisms being identified and explicitly countered?
- Is double-loop learning occurring at the individual, team, and organizational levels?

**Typical use cases:**
- Organizational strategy review when persistent underperformance suggests framework failure
- Leadership development and executive coaching
- Culture change initiatives requiring governing-value revision
- After-action reviews in complex, adaptive environments

**Strengths and limitations:** Double-loop learning addresses one of the deepest failure modes of organizations and individuals: persisting with a flawed framework because the mechanisms for questioning it are suppressed by defensive reasoning. Argyris's research shows that this failure is nearly universal in human organizations and is the primary explanation for why intelligent people repeatedly fail in the same ways. The limitation is that double-loop learning is genuinely difficult to initiate: the defensive mechanisms that protect governing values are powerful, and making the governing values themselves the object of inquiry often feels existentially threatening. Psychological safety at the organizational level is a prerequisite.

**Related frameworks:** Systems Thinking, Cynefin Framework, After-Action Review, OODA Loop, Growth Mindset Framework

---

### Analogical Reasoning

**Category:** Analytical Reasoning
**Tags:** analogy, transfer, Gentner, cross-domain, innovation
**How it works:** Analogical reasoning is the cognitive process of transferring structural or relational knowledge from a source domain (where the relationship is understood) to a target domain (where the corresponding structure is not yet understood). Unlike literal similarity, which requires identical features, analogical reasoning identifies and applies abstract structural relationships—A is to B as C is to D—across domains with different surface features. Dedre Gentner's Structure-Mapping Theory (1983) formalizes how analogy maps relational structure rather than object attributes. In decision-making and problem-solving, analogical reasoning enables practitioners to apply solutions from well-understood domains to novel problems, to generate hypotheses by importing explanatory frameworks, and to communicate complex ideas through familiar examples. The most transformative innovations in science and business often arise from importing an analogy from one field into another.

**Dimensions / components:**
- Source domain: the familiar domain from which structural knowledge is drawn
- Target domain: the novel domain to which structural knowledge is applied
- Mapping: the correspondence between source and target elements
- Relational match: structural similarity (relationships between elements) rather than surface similarity
- Inferential transfer: importing inferences from source that might hold in target
- Disanalogy detection: identifying where the analogy breaks down

**Guiding questions:**
- What familiar situation is structurally similar to this novel problem?
- What solution worked in the source domain, and can it transfer to the target?
- Is the analogy based on relational similarity or only on superficial features?
- Where does the analogy break down—where are the structural disanalogies?
- Have I checked whether the solution from the source domain actually applies in the target context?

**Evaluation criteria:**
- Is the analogy based on structural/relational similarity rather than superficial feature matching?
- Has the mapping between source and target elements been explicitly stated?
- Have disanalogies—places where the structure breaks down—been identified?
- Has the transferred inference been tested in the target domain rather than merely assumed?
- Is the analogy the most structurally similar source available, or is a better source being overlooked?

**Typical use cases:**
- Scientific hypothesis generation
- Product innovation by importing solutions from adjacent industries
- Legal reasoning by precedent and case analogy
- Communication and education through explanatory metaphor

**Strengths and limitations:** Analogical reasoning is one of the most powerful engines of creative problem-solving and scientific discovery—many fundamental advances in physics, biology, and engineering arose from structural analogies imported from other fields. It is also the basis of legal precedent and institutional knowledge transfer. Its limitation is that surface similarity is much more cognitively salient than structural similarity, causing practitioners to apply analogies based on shared features rather than shared relationships—producing misleading rather than helpful transfers. Explicit structure-mapping discipline substantially reduces this risk.

**Related frameworks:** Mental Model Lattice (Munger), First Principles Thinking, Abductive Reasoning, Cross-Domain Innovation, Case-Based Reasoning

---

### Sensitivity Analysis

**Category:** Analytical Reasoning
**Tags:** robustness, model testing, uncertainty, assumptions, quantitative
**How it works:** Sensitivity analysis is the practice of systematically varying the assumptions and input values of an analytical model to determine how much the output changes in response—identifying which inputs drive output variance most, and testing whether conclusions are robust to reasonable changes in assumptions. In decision analysis, a conclusion is robust if it remains valid across a wide range of plausible input values; it is sensitive if small changes in key inputs reverse the conclusion. Sensitivity analysis is applied as one-way analysis (varying one input at a time), two-way analysis (varying two inputs simultaneously to map their interaction), or multi-way (Monte Carlo) analysis across all uncertain inputs simultaneously. The output is a map of "how wrong would my inputs have to be for my conclusion to be wrong?" This directly informs where additional data collection effort should be focused: on the high-sensitivity, high-uncertainty inputs.

**Dimensions / components:**
- Input identification: all variable assumptions in the model
- Baseline case: the central-estimate model output
- One-way sensitivity: varying each input independently across its plausible range
- Two-way sensitivity: varying pairs of inputs to identify interaction effects
- Tornado diagram: ranking inputs by their impact on output variance
- Robustness threshold: the input value at which the conclusion reverses

**Guiding questions:**
- Which input assumptions drive the most output variance in this model?
- What change in my most sensitive input would reverse the conclusion?
- Is the conclusion robust across the full plausible range of input values?
- Where should additional data collection be focused to reduce output uncertainty most?
- Are input assumptions correlated, and have those correlations been captured?

**Evaluation criteria:**
- Have all material input uncertainties been included in the sensitivity analysis?
- Is the plausible range for each input realistic and evidence-based?
- Is the analysis reported as a tornado diagram or equivalent visualizing relative sensitivity?
- Are the conclusion's robustness thresholds explicitly stated and compared to plausible input ranges?
- Have correlated inputs been identified and modeled as such rather than varied independently?

**Typical use cases:**
- Financial model and valuation analysis
- Regulatory impact assessment and cost-benefit analysis
- Clinical trial and health technology assessment
- Engineering design safety analysis

**Strengths and limitations:** Sensitivity analysis is essential for any quantitative decision model because all models contain uncertain assumptions, and conclusions that appear robust in a base case are often fragile when key assumptions are stress-tested. Its systematic approach to quantifying fragility is uniquely informative for prioritizing additional research and for communicating decision risk to stakeholders. Its limitation is that one-way analysis—varying inputs independently—misses the interaction effects between correlated inputs that can dominate in complex systems. Full Monte Carlo simulation is required to capture these interactions, at the cost of greater complexity.

**Related frameworks:** Monte Carlo Simulation, Cost-Benefit Analysis, Decision Trees, Weighted Decision Matrix, Bayesian Updating

---

### Abductive Reasoning

**Category:** Analytical Reasoning
**Tags:** Peirce, inference to best explanation, hypothesis, diagnosis, detective
**How it works:** Abductive reasoning, formalized by the American philosopher Charles Sanders Peirce, is inference to the best explanation—the selection of the hypothesis that, if true, would most elegantly and economically explain the observed evidence. Unlike deduction (which derives necessary conclusions from premises) or induction (which generalizes from observed instances to general rules), abduction starts with an observation and asks what explanation would make that observation most intelligible. Abduction is the mode of reasoning that underpins diagnostic judgment in medicine, detective work (Sherlock Holmes's reasoning is paradigmatically abductive), scientific hypothesis generation, and much of everyday problem-solving. Its output is a hypothesis, not a proven conclusion: the best explanation according to current evidence should then be tested deductively or experimentally. Peirce saw abduction as the only form of reasoning that generates genuinely new ideas.

**Dimensions / components:**
- Observation: a fact or pattern requiring explanation
- Candidate hypotheses: potential explanations for the observation
- Explanatory criteria: simplicity, breadth, depth, analogy to known patterns
- Best-explanation selection: choosing the hypothesis with the highest explanatory score
- Hypothesis testing: converting the abductive conclusion into testable predictions
- Iterative revision: updating the best-explanation hypothesis as evidence accumulates

**Guiding questions:**
- What is the most surprising or puzzling observation requiring explanation?
- What hypothesis would make this observation most natural and intelligible?
- Among candidate hypotheses, which is simplest, most consistent with background knowledge, and most explanatorily comprehensive?
- What observable prediction would allow me to test whether the best-explanation hypothesis is correct?
- Does the current best explanation remain best-explanation after additional evidence, or should I revise?

**Evaluation criteria:**
- Have multiple candidate hypotheses been generated before selecting the best?
- Is the selected hypothesis genuinely the most explanatorily powerful, or merely the most familiar?
- Has the hypothesis been converted into testable predictions?
- Is the practitioner avoiding premature closure on the first plausible explanation?
- Is the abductive conclusion appropriately held as provisional rather than proven?

**Typical use cases:**
- Medical and clinical diagnosis
- Criminal investigation and intelligence analysis
- Scientific hypothesis generation
- Business and organizational problem diagnosis

**Strengths and limitations:** Abductive reasoning is the primary cognitive engine of both scientific discovery and expert diagnostic judgment. Making it explicit—generating multiple candidate hypotheses before selecting—dramatically improves diagnostic accuracy and prevents premature closure, which is the dominant failure mode in clinical and investigative reasoning. Its limitation is that "best explanation" is a context-dependent judgment, and the criteria for explanatory goodness (simplicity, breadth, analogy) can conflict. The abductive conclusion is always provisional and must be subjected to rigorous deductive testing; treating abductive inference as proof is a common and dangerous error.

**Related frameworks:** Scientific Method, Bayesian Updating, Falsificationism, Root Cause Analysis, Analogical Reasoning

---

### Pre-commitment and Ulysses Contract

**Category:** Analytical Reasoning / Decision-Making
**Tags:** self-control, commitment devices, behavioral economics, future-self, temptation
**How it works:** Pre-commitment is the strategy of voluntarily restricting one's future choices—or making the cost of deviating from a chosen course very high—in order to protect a long-term goal from the predictable interference of future short-term preferences. The name derives from the Homeric story of Odysseus (Ulysses), who had himself bound to the mast so that he could hear the Sirens' song without being able to act on the impulse to follow it. In behavioral economics, pre-commitment addresses time inconsistency—the systematic tendency to prefer immediate gratification over delayed larger rewards when the immediate option is available, even when we would have chosen differently in advance. Pre-commitment mechanisms include: automatic savings enrollment, contractual penalties for non-performance (stickK.com model), removal of temptation from the environment, and public commitment creating social accountability.

**Dimensions / components:**
- Identification of the time-inconsistency problem: what future self will the current self want to override?
- Pre-commitment mechanism: the device that makes deviation costly or impossible
- Flexibility-cost trade-off: how much optionality is sacrificed to enforce commitment?
- Verification: how will compliance with the commitment be monitored?
- Escape clause design: what genuinely catastrophic future circumstances should unlock the commitment?
- Social accountability: public commitment as a commitment device

**Guiding questions:**
- In what situations do I predictably fail to follow through on intentions I genuinely hold today?
- What mechanism could make deviation from the intended path costly enough to deter my future self?
- Am I accepting appropriate flexibility sacrifice to achieve the value of the commitment?
- What monitoring or verification will enforce the commitment?
- Have I designed the escape clause carefully enough that it only triggers in genuine emergencies?

**Evaluation criteria:**
- Is the time-inconsistency problem clearly identified and the commitment mechanism targeted at it?
- Is the commitment mechanism credible—would the cost of defection actually deter the future self?
- Is there a legitimate and limited escape clause for genuine emergencies?
- Is the commitment monitored externally or verified by social accountability?
- Is the flexibility sacrifice proportionate to the value of the commitment?

**Typical use cases:**
- Retirement savings and long-term financial planning (automatic enrollment)
- Health behavior change and addiction recovery
- Personal productivity and creative output commitments
- Organizational governance rules designed to prevent short-term political deviation

**Strengths and limitations:** Pre-commitment is one of the most practically powerful applications of behavioral economics because it works with—rather than against—the predictable irrationality of future-self preferences. When properly designed, commitment devices have dramatically higher success rates than willpower-based intention maintenance. The limitation is that pre-commitment requires accurate prediction of future temptation and the availability of a credible binding mechanism, neither of which is always achievable. Over-rigid pre-commitments can also backfire by triggering "what the hell" effects when deviation occurs once, causing complete collapse rather than recovery.

**Related frameworks:** Sunk Cost Fallacy Debiasing, Status Quo Bias Debiasing, Nudge Design, Dual Process Theory, Regret Minimization Framework, Overconfidence Effect Debiasing
---
