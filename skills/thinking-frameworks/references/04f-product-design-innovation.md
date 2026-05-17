## Product, Design, and Innovation — Part 6/6

<!-- Frameworks in this file: Lean Analytics, Pirate Metrics — Referral Loop (Viral Coefficient), Cognitive Walkthrough, Five Whys -->

### Lean Analytics
**Category:** Growth / Experimentation
**Tags:** Alistair Croll, Ben Yoskovitz, one metric that matters, stage-appropriate metrics, OMTM
**How it works:** Lean Analytics, developed by Alistair Croll and Ben Yoskovitz and published in their 2013 book of the same name, is a framework for identifying and tracking the right metrics at the right stage of a product's development. Its central concept is the "One Metric That Matters" (OMTM) — the single most important metric that the team should focus on optimizing right now, given the company's current stage and business model. The framework maps different business model types (e-commerce, SaaS, mobile, marketplace, media) against different stages of development (empathy, stickiness, virality, revenue, scale) to recommend which specific metric deserves the team's primary focus. This prevents the metric proliferation that causes teams to optimize locally and lose strategic focus.
**Dimensions / components:**
- One Metric That Matters (OMTM) — the single metric most critical to optimize at the current stage
- Business model types — e-commerce, SaaS, freemium, mobile app, user-generated content, marketplace
- Stage framework — Empathy, Stickiness, Virality, Revenue, Scale
- Stage-appropriate metrics — recommended metrics per model type per stage
- Vanity metrics — metrics that look good but don't inform decisions (page views, registered users)
- Actionable metrics — metrics that reveal cause-and-effect and drive decisions
- Good vs. bad metrics — distinction by actionability, comparability, and behavior change potential
**Guiding questions:**
- What is our business model type, and what stage of development are we in?
- What is the single most important metric we should improve right now?
- Are our current metrics actionable — do they tell us why something is happening, not just that it is?
- Which of our tracked metrics are vanity metrics that we should deprioritize?
- Does improving our OMTM this quarter advance our position toward the next development stage?
**Evaluation criteria:**
- Accuracy of business model type and development stage assessment
- Relevance of OMTM to current stage (not premature focus on revenue before stickiness)
- Reduction in the number of active KPIs being tracked simultaneously
- Clarity of cause-and-effect interpretation from OMTM changes
- Team alignment on OMTM priority across product, engineering, and growth
**Typical use cases:**
- Early-stage startup metric selection and growth prioritization
- Growth team focus selection in Series A/B companies
- Investor communication about stage-appropriate success metrics
- Preventing metric sprawl in data-rich product organizations
**Strengths and limitations:** Lean Analytics provides a pragmatic, stage-aware alternative to tracking everything, helping teams achieve focus in data-rich environments that otherwise produce analysis paralysis. The OMTM concept is particularly valuable for small teams with limited data infrastructure capacity. Its limitation is that the stage and model type framework requires judgment to apply — real companies often have hybrid or evolving models that don't fit neatly into the taxonomy.
**Related frameworks:** North Star Metric, AARRR, OKRs, Growth Loop Model, Product-Market Fit, Balanced Scorecard

---

### Pirate Metrics — Referral Loop (Viral Coefficient)
**Category:** Growth / Experimentation
**Tags:** viral growth, K-factor, referral mechanics, network effects, word-of-mouth, viral coefficient
**How it works:** The Viral Coefficient (K-factor) framework quantifies the self-sustaining growth potential of a product's referral mechanism. K = (average invitations sent per user) × (conversion rate of invitations to active users). A K-factor above 1.0 means each new user generates more than one additional user — the product is growing exponentially without paid acquisition. A K-factor below 1.0 but above 0 indicates referral supplements but does not replace acquisition channels. The framework guides product decisions around which referral mechanics to invest in, what friction reduces conversion, and how to improve invitation quantity and quality. It connects directly to growth loop design and the AARRR referral stage, providing a quantitative operationalization of viral growth dynamics.
**Dimensions / components:**
- K-factor formula — (invitations per user) × (invitation conversion rate)
- Invitation quantity — how many referrals each user sends (driven by incentive and ease)
- Invitation conversion rate — proportion of invited people who become active users
- Viral cycle time — how long a complete referral cycle takes
- Organic vs. incentivized virality — inherent product sharing vs. referral program mechanics
- Network effect relationship — how K-factor amplification relates to network value density
**Guiding questions:**
- What is our current K-factor, and is it above or below 1.0?
- Is the primary constraint invitation quantity (users don't share enough) or conversion rate (invites don't convert)?
- Does our product create genuine natural sharing moments — or does referral feel forced?
- How does viral cycle time affect our K-factor's contribution to monthly growth rates?
- What product features or incentive structures would most efficiently increase K?
**Evaluation criteria:**
- Accuracy of K-factor measurement across cohorts
- Separation of organic from incentivized referral contributions
- Improvement trajectory of K-factor following referral experience interventions
- Correlation between K-factor and long-term retention (incentivized-only virality often churns)
- Sustainability of referral mechanics at scale without increasing friction
**Typical use cases:**
- Consumer app referral program design and optimization
- Social product virality analysis
- Growth model feasibility assessment for investor presentations
- Marketplace growth strategy where buyer-side and seller-side referral compound
**Strengths and limitations:** The K-factor provides a clean, quantitative handle on referral effectiveness that is directly actionable — teams can experiment on invitation quantity and conversion rate independently. It reveals whether a product has latent viral potential or is fundamentally non-viral. Its limitation is that K-factor can be temporarily inflated by aggressive incentive programs that attract low-quality users who churn quickly, producing misleading signals about organic viral health.
**Related frameworks:** AARRR Pirate Metrics, Growth Loop Model, North Star Metric, Product-Market Fit, Network Effects Framework, Behavioral Design

---

### Cognitive Walkthrough
**Category:** UX Research / Usability
**Tags:** usability inspection, learnability, task completion, expert review, Polson and Lewis
**How it works:** The Cognitive Walkthrough is a usability inspection method developed by Clayton Lewis, Peter Polson, and colleagues that evaluates an interface from the perspective of a new user performing a specific task for the first time, focusing on learnability rather than efficiency. Evaluators step through the task sequence action by action, asking four questions at each step: Will users know what to try? Will users recognize that the correct action is available? Will users understand from feedback whether they performed the action correctly? Will users understand from feedback that they are on the right path? Where the answer is "no," a usability problem is documented. Unlike Heuristic Evaluation (which is holistic), the Cognitive Walkthrough is highly task-specific and oriented toward first-use discovery.
**Dimensions / components:**
- Task specification — the specific user goal and starting state for the walkthrough
- Action sequence — the correct series of steps to complete the task
- Four walkthrough questions — applied at each action step
- Failure stories — narratives explaining why users might fail at each step
- Success stories — explanations of what supports correct action execution
- Problem documentation — usability issues classified by walkthrough failure question
**Guiding questions:**
- For this action, will a new user know what to try — is the correct action discoverable without instruction?
- Is the affordance for this action visible and appropriately labeled in the interface?
- Does the system's feedback clearly confirm that the user took the right action?
- If the user takes an incorrect action, does feedback clearly redirect them?
- At which steps in the task sequence is the "no" answer most consequential for user success?
**Evaluation criteria:**
- Completeness of task specification before the walkthrough begins
- Rigor of failure story documentation at problematic steps
- Specificity of redesign recommendations for each identified failure
- Comparison to think-aloud findings from actual users on the same task
- Coverage of the most critical user tasks in the product
**Typical use cases:**
- Evaluating learnability of a complex enterprise software workflow
- Accessibility evaluation for users with no prior system knowledge
- Comparing competing design concepts for first-use experience
- Pre-launch assessment when user testing time is limited
**Strengths and limitations:** The Cognitive Walkthrough is faster than user-based testing and particularly effective at identifying learnability failures at specific interaction points — it excels for first-use scenarios in complex systems. It requires minimal participant recruitment. Its limitation is that it focuses exclusively on learnability, missing efficiency, error recovery, and satisfaction issues that experienced users encounter, and evaluator expertise significantly affects finding quality.
**Related frameworks:** Heuristic Evaluation, Think-Aloud Protocol, Usability Testing, Contextual Inquiry, Expert Review, Accessibility Audit

---

### Five Whys
**Category:** Product Management / Service Design
**Tags:** Taiichi Ohno, Toyota, root cause analysis, Lean, problem-solving, iterative questioning
**How it works:** The Five Whys is a root cause analysis technique developed by Taiichi Ohno as part of the Toyota Production System and widely adopted across Lean, Agile, and service design practices. When a problem occurs, the analyst asks "Why?" and documents the answer. Then asks "Why?" again about that answer. This iterative questioning process continues — typically five times — until the root cause is reached: the fundamental systemic reason the problem occurred, rather than the immediate symptom. The technique is based on the insight that most problems in systems are caused by systemic failures (inadequate processes, structures, or incentives) rather than individual errors, and that treating symptoms without addressing root causes produces recurring failures.
**Dimensions / components:**
- Problem statement — a clear, specific description of the observable problem
- Why 1–5 — five successive iterations of causal questioning
- Root cause — the systemic failure at the end of the causal chain
- Evidence requirement — each "why" answer should be based on observation, not assumption
- Branching — problems may have multiple causal chains requiring parallel five-whys analysis
- Corrective action — the specific systemic intervention targeting the identified root cause
**Guiding questions:**
- Are we treating the symptom or the root cause — and how do we know?
- At which "why" level does the cause shift from individual error to systemic failure?
- Is each causal link supported by evidence — or are we speculating?
- If we fix this root cause, would this problem and similar problems also be prevented?
- What systemic intervention (process, training, tool, structure) addresses the root cause?
**Evaluation criteria:**
- Depth of causal analysis (reaching systemic causes, not stopping at symptoms)
- Evidence-grounding of each causal link
- Specificity and actionability of the corrective action targeting the root cause
- Team-level agreement on the identified root cause
- Recurrence rate of the problem after root cause correction
**Typical use cases:**
- Product incident and outage post-mortems
- Customer support escalation root cause analysis
- Sprint retrospective problem investigation
- Manufacturing and service process failure analysis
**Strengths and limitations:** Five Whys is remarkably simple, fast, and accessible — requiring no special training or tools — and reliably moves teams from symptom-level reactions to systemic causal understanding. It is particularly effective for recurring operational problems. Its limitation is that it assumes a single linear causal chain, while complex system failures typically have multiple interacting causes. In those contexts, fishbone (Ishikawa) diagrams or systems mapping provide more appropriate multi-cause analysis.
**Related frameworks:** Pre-Mortem, Sprint Retrospective, Iceberg Model, Service Blueprint, Lean UX, Root Cause Analysis
