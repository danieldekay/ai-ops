## Product, Design, and Innovation — Part 5/6

<!-- Frameworks in this file: Experience Sampling Method (ESM), Crazy 8s, Point of View (POV) Statement, Net Promoter Score (NPS) Framework, Feature Flagging / Progressive Delivery, Rapid Prototyping, Stakeholder Mapping, Lateral Thinking, Sprint Retrospective and Kaizen, Jobs-to-Be-Done — Forces of Progress Model, Technology Readiness Level (TRL), Agile Roadmapping with Themes, Behavioral Design (BJ Fogg's Behavior Model), Minimal Viable Product (MVP) Taxonomy -->

### Experience Sampling Method (ESM)
**Category:** UX Research
**Tags:** momentary assessment, in-the-moment, Csikszentmihalyi, ecological validity, longitudinal
**How it works:** The Experience Sampling Method (ESM), developed by Mihaly Csikszentmihalyi and colleagues in the 1970s, is a systematic research technique that prompts participants to report their current experiences, emotions, and behaviors at random or signal-contingent intervals throughout the day via mobile devices or paging systems. Unlike diary studies (which rely on retrospective recall) or lab studies (which are decontextualized), ESM captures experience in the moment and in its natural context, producing ecologically valid data about emotional states, activities, and situational factors as they actually occur. Modern implementations use smartphone apps to deliver prompts and collect multi-dimensional reports covering affect, cognition, environment, and behavior simultaneously.
**Dimensions / components:**
- Signal type — random (time-contingent), event-contingent, or interval-based prompts
- Report form — standardized multi-item momentary assessment questionnaire
- Ecological validity — data collected in natural context during real-life activities
- Sampling period — typically 1–2 weeks with 4–10 prompts per day
- Affect measures — positive and negative emotional state items
- Activity measures — what the participant is doing and with whom at the moment of prompt
- Analysis — multi-level modeling to distinguish between-person from within-person variability
**Guiding questions:**
- What emotional states and situational contexts do users experience while engaging with our product?
- How does mood, stress, or social context affect product engagement or satisfaction in the moment?
- What are users actually doing when they reach for our product, versus what they say they do in retrospective interviews?
- How does experience vary across the time of day, day of week, or situation type?
- Where do peaks and troughs in emotional experience cluster relative to specific product interactions?
**Evaluation criteria:**
- Response rate and compliance throughout the sampling period
- Prompt frequency balance between data richness and participant burden
- Validity and reliability of momentary assessment scales used
- Ecological representativeness of sampling period
- Translation of ESM findings into specific design implications
**Typical use cases:**
- Wellbeing and mental health application research
- Understanding emotional context of product engagement for consumer apps
- Workplace tool research in organizational psychology studies
- Validating survey-based attitude measures against momentary experience data
**Strengths and limitations:** ESM provides the most ecologically valid and temporally rich data available in behavioral research, capturing the dynamic, contextual nature of experience that no other single-session or retrospective method can access. Its main limitation is participant burden — high prompt frequency over multiple weeks leads to significant attrition and careless responding — and the analysis requires specialized statistical expertise (multi-level modeling).
**Related frameworks:** Diary Studies, Contextual Inquiry, Think-Aloud Protocol, Empathy Mapping, Ethnographic Research, Longitudinal UX Research

---

### Crazy 8s
**Category:** Ideation / Design Thinking
**Tags:** Design Sprint, rapid sketching, divergent thinking, 8 ideas, 8 minutes, visual thinking
**How it works:** Crazy 8s is a fast-paced design ideation exercise popularized through the Google Ventures Design Sprint methodology. Each participant takes a sheet of paper, folds it into eight panels, and sketches eight distinct ideas or variations in eight minutes — one per panel, one minute per sketch. The constraint is deliberately extreme: the goal is not to produce polished concepts but to force the brain to move past its first (and usually most conventional) ideas and explore a broader solution space. After eight rounds of forced ideation, the group reviews sketches and discusses the most generative directions. Crazy 8s is particularly effective immediately after problem reframing, when teams have a clear challenge but need to explore the full breadth of possible solutions before converging.
**Dimensions / components:**
- Eight panels — the paper divided into 8 equal sections, one per idea
- Eight minutes — strict time limit enforcing one minute per sketch
- Individual sketching — participants work silently and independently
- Divergent pressure — the time constraint forces movement beyond obvious first ideas
- Visual medium — sketches rather than text to externalise ideas quickly
- Review and discussion — gallery walk or wall posting of all sketches post-exercise
- Heat map voting — dot voting on the most compelling concepts after review
**Guiding questions:**
- Have we already sketched our first obvious idea — and can we now push further?
- Which of the eight ideas is most surprising, and what does that surprise signal?
- Are any two ideas on different sketches combinable into a stronger concept?
- Which ideas most directly address the challenge statement we defined?
- What wild ideas emerged that, if taken seriously, could be the most innovative direction?
**Evaluation criteria:**
- Diversity of sketched concepts relative to the starting idea set
- Movement beyond the first or second idea into genuinely novel territory
- Volume of concepts produced per session across all participants
- Quality of post-sketch discussion and pattern recognition
- Proportion of sketches that contribute to subsequent prototyping decisions
**Typical use cases:**
- Idea generation within Design Sprint Monday/Tuesday sessions
- Design thinking workshop ideation phases
- Product team kickoff sessions to explore a new problem space
- Breaking creative stalemates in teams anchored on a single solution
**Strengths and limitations:** Crazy 8s reliably generates high idea volume in a short time and prevents anchoring on initial concepts by forcing movement through eight successive sketches. Its visual format externalizes thinking in ways that verbal discussion cannot. Its limitation is that the extreme time constraint can produce superficial sketches that fail to capture nuanced ideas, and participants unfamiliar with sketching as a thinking tool may find it intimidating.
**Related frameworks:** Design Sprint, How-Might-We Statements, Design Thinking, SCAMPER, Brainstorming, Six Thinking Hats

---

### Point of View (POV) Statement
**Category:** Design Thinking / UX Research
**Tags:** problem framing, need statement, insight, user-centered, d.school, problem definition
**How it works:** The Point of View (POV) statement is a problem-definition tool developed at the Stanford d.school as part of the Design Thinking process. It crystallizes synthesis from empathy research into a sharp, actionable human-centered problem statement that guides ideation. A POV statement follows a three-part structure: [User] needs [need] because [insight]. The "user" is a specific individual or archetype, not a demographic category. The "need" is a verb-anchored statement of what the user needs to accomplish — not the solution. The "insight" is the surprising or non-obvious truth revealed by research that reframes why this need exists and why current solutions miss it. A well-crafted POV is generative: it inspires many How-Might-We ideation questions and rules out off-target solutions.
**Dimensions / components:**
- User — specific, research-grounded individual or archetype (not a demographic)
- Need — a verb-driven statement of what the user needs to accomplish or experience
- Insight — the unexpected, non-obvious research finding that reframes the need
- Three-part syntax — [User] needs [need] because [insight]
- Generativity test — does the POV inspire multiple different ideation directions?
- Exclusivity test — does the POV rule out off-target solutions?
- Laddering — moving the POV up (more abstract) or down (more specific) to find the right scope
**Guiding questions:**
- Is the user specific and research-grounded, or is it a vague demographic category?
- Is the need framed as a human need rather than a feature request or solution?
- What unexpected insight from our research most reframes why this need exists?
- Does this POV generate energy — do we want to solve it — or is it lifeless?
- How many different How-Might-We statements can we derive from this POV?
**Evaluation criteria:**
- Specificity and research grounding of the user description
- Clarity and human-centeredness of the need statement
- Non-obviousness and reframing power of the insight
- Generativity: number of distinct ideation directions the POV inspires
- Team alignment on the POV before ideation begins
**Typical use cases:**
- Define phase of Design Thinking processes
- Design Sprint problem definition on Monday
- Research synthesis sessions following empathy fieldwork
- Problem framing workshops preceding solution ideation
**Strengths and limitations:** The POV statement is a powerful synthesis and communication tool that forces teams to make an explicit, committal statement about who they are designing for and what they believe the core need is. A good POV aligns teams and energizes ideation. Its limitation is that it requires high-quality empathy research as input — without rich fieldwork, POV statements become articulate expressions of team assumptions.
**Related frameworks:** Empathy Mapping, How-Might-We Statements, Design Thinking, Affinity Mapping, Persona Development, Opportunity Solution Tree

---

### Net Promoter Score (NPS) Framework
**Category:** Product Management / UX Research
**Tags:** Fred Reichheld, loyalty, promoters, passives, detractors, customer feedback, product health
**How it works:** Net Promoter Score, developed by Fred Reichheld and published in *Harvard Business Review* in 2003, is a customer loyalty metric derived from a single survey question: "On a scale of 0–10, how likely are you to recommend this product/company to a friend or colleague?" Respondents are classified as Promoters (9–10), Passives (7–8), or Detractors (0–6). The NPS score equals % Promoters minus % Detractors, ranging from −100 to +100. In product management practice, NPS is most valuable not as an aggregate number but as a segmentation tool: qualitative follow-up questions with Detractors and Promoters reveal specific product strengths and failures, informing roadmap decisions. Relationship NPS (periodic survey) and Transactional NPS (post-interaction survey) serve different diagnostic purposes.
**Dimensions / components:**
- The recommend question — "How likely are you to recommend…?" (0–10 scale)
- Promoters (9–10) — enthusiastic loyalists who drive word-of-mouth growth
- Passives (7–8) — satisfied but unenthusiastic; vulnerable to competitive offers
- Detractors (0–6) — unhappy customers who can damage brand through negative word-of-mouth
- NPS Score — % Promoters − % Detractors
- Verbatim follow-up — open-ended "What is the primary reason for your score?" question
- Closed-loop follow-up — reaching out to Detractors to understand and resolve issues
**Guiding questions:**
- What are Detractors most frequently citing as the reason for their low score?
- What product strengths are Promoters most consistently attributing their loyalty to?
- How is NPS trending over time — and does the trend correlate with specific product changes?
- Is our NPS higher or lower in specific user segments, and what explains the difference?
- Are we using closed-loop NPS to convert Detractors — not just measuring them?
**Evaluation criteria:**
- Representativeness and timing of NPS survey distribution
- Response rate relative to total user base
- Quality and actionability of verbatim follow-up responses
- Correlation between NPS trends and product and growth metrics
- Cadence of closed-loop follow-up with Detractors
**Typical use cases:**
- Product health monitoring and longitudinal loyalty tracking
- Identifying priority product improvement areas from Detractor feedback
- Benchmarking against industry NPS standards
- Investor and board reporting on customer satisfaction
**Strengths and limitations:** NPS is one of the most widely used customer feedback metrics globally, valued for its simplicity and cross-industry benchmarkability. Its single-question format enables high response rates. Its well-documented limitations include poor sensitivity to specific product issues, susceptibility to cultural response biases (global scale variation), and the fact that the "likelihood to recommend" question is a poor predictor of actual behavior in many categories.
**Related frameworks:** Kano Model, Customer Journey Map, AARRR, Continuous Discovery, User Interviews, Product-Market Fit

---

### Feature Flagging / Progressive Delivery
**Category:** Experimentation / Product Management
**Tags:** feature flags, progressive rollout, dark launch, canary release, risk management, deployment
**How it works:** Feature flagging (also called feature toggles) is an engineering and product practice that decouples code deployment from feature release by wrapping new functionality in conditional logic controlled by configuration rather than deployment. Progressive delivery extends this by enabling gradual, controlled rollouts to increasing percentages of users — canary releases (1% → 5% → 25% → 100%), targeted releases to specific segments, and instant kill-switch rollbacks if problems emerge. This practice eliminates the binary ship/don't-ship decision, enabling product teams to test performance and user behavior with real users at scale before committing to full release, while maintaining the ability to instantly revert.
**Dimensions / components:**
- Feature flag — a conditional code toggle controlled by a configuration system
- Progressive rollout — gradual traffic percentage increase for a new feature
- Canary release — deploying to a small initial cohort before broader rollout
- Targeted release — releasing to a specific user segment (beta users, power users, market)
- Kill switch — instant feature disable without code rollback
- A/B test integration — using flags to create experiment cohorts
- Flag lifecycle management — creating, monitoring, and cleaning up flags
**Guiding questions:**
- Are we designing features to be flag-wrapped from the start, or retrofitting flags after the fact?
- What is the rollout percentage at which we would feel confident moving to 100%?
- What monitoring and alerting is in place to detect problems during progressive rollout?
- Are we cleaning up stale flags, or accumulating technical debt from permanent flags?
- How are we using flag data — guardrail metrics — to make rollout decisions?
**Evaluation criteria:**
- Mean time to detect issues during progressive rollout
- Mean time to roll back if problems are detected
- Percentage of features shipped via progressive delivery versus big-bang releases
- Stale flag accumulation rate as a technical debt indicator
- Correlation between progressive delivery adoption and deployment confidence
**Typical use cases:**
- High-scale consumer product releases where bugs could affect millions of users
- Continuous deployment environments where weekly or daily releases are standard
- Regulated industry releases requiring staged validation before full deployment
- Multi-variant A/B testing infrastructure
**Strengths and limitations:** Feature flagging dramatically reduces release risk by enabling surgical rollbacks and progressive validation with real users, and it decouples the engineering deployment cycle from the business release decision. It is foundational to continuous delivery organizations. Its limitation is operational complexity — without disciplined flag lifecycle management, codebases accumulate "flag debt" that increases cognitive load and introduces bugs.
**Related frameworks:** A/B Testing, Hypothesis-Driven Development, Agile/Scrum, Continuous Discovery, Lean Startup, Canary Deployment Patterns

---

### Rapid Prototyping
**Category:** Design Thinking / Experimentation
**Tags:** low-fidelity, paper prototype, mockup, iteration, validation, Wizard of Oz, user testing
**How it works:** Rapid Prototyping is the practice of quickly creating low-fidelity, tangible representations of ideas to gather learning before investing in high-fidelity development. Prototypes exist on a spectrum from paper sketches and cardboard models through clickable wireframes, coded prototypes, and pilot services. The defining principle is that prototype fidelity should match the question being tested — only invest in higher fidelity when the additional cost is justified by the learning required. Common rapid prototyping techniques include paper prototyping (hand-drawn interface sketches), Wizard of Oz testing (a human manually simulates an automated feature), clickable wireframe prototypes (Figma, InVision), and concierge MVPs (manual service delivery simulating a future automated product).
**Dimensions / components:**
- Fidelity spectrum — paper → wireframe → interactive prototype → coded prototype → pilot
- Paper prototype — hand-drawn interface screens tested with users
- Wizard of Oz — human operator simulating automated system behind the scenes
- Concierge MVP — manual service delivery to test product concept before building
- Clickable wireframe — static screens linked to simulate user flows
- Prototype scope — only the minimal scope required to test the specific hypothesis
- Testing integration — every prototype is designed to generate specific learning
**Guiding questions:**
- What specific question must this prototype answer?
- What is the minimum fidelity required to answer that question with users?
- Are we investing in prototype polish before we need it — optimizing for presentation rather than learning?
- What user reactions would cause us to abandon this direction entirely?
- How quickly can we build and test this prototype — and if not within a day, is the fidelity too high?
**Evaluation criteria:**
- Minimum fidelity matched to the learning question
- Speed from idea to testable prototype
- Quality of user learning generated per prototype
- Willingness to discard prototypes based on negative test results
- Ratio of prototypes tested to features eventually built
**Typical use cases:**
- Early-stage concept validation before engineering investment
- Usability testing of new interaction patterns
- Service concept testing in Design Sprint contexts
- A/B concept testing with qualitative research participants
**Strengths and limitations:** Rapid Prototyping dramatically reduces the cost of learning by enabling teams to test ideas with users before committing engineering resources. The lower the fidelity, the more honest the feedback — users engage more critically with sketches than polished interfaces. Its limitation is the skill required to match prototype fidelity appropriately to the learning question, and the organizational pressure to "make it look good" that inflates fidelity beyond what learning requires.
**Related frameworks:** Design Thinking, Design Sprint, Lean Startup, A/B Testing, Usability Testing, Think-Aloud Protocol

---

### Stakeholder Mapping
**Category:** Product Management / Service Design
**Tags:** stakeholder analysis, influence-interest matrix, power-interest, change management, alignment
**How it works:** Stakeholder Mapping is the systematic identification, analysis, and prioritization of all individuals, groups, and organizations who have an interest in or influence over a product, project, or strategy. The most widely used analytical tool is the Power–Interest Grid (attributed to Aubrey Mendelow), which plots stakeholders on two axes — their power to affect the initiative and their interest level — producing four quadrants: Manage Closely (high power, high interest), Keep Satisfied (high power, low interest), Keep Informed (low power, high interest), and Monitor (low power, low interest). Engagement strategies are tailored to each quadrant. For product teams, stakeholder maps reveal who must be managed proactively, whose concerns can derail progress, and whose support is needed for organizational legitimacy.
**Dimensions / components:**
- Stakeholder identification — comprehensive enumeration of all affected parties
- Power axis — degree of formal or informal ability to affect the initiative's success or failure
- Interest axis — degree of attention and concern the stakeholder has in the initiative's outcome
- Manage Closely quadrant — key stakeholders requiring active engagement and communication
- Keep Satisfied quadrant — powerful but low-interest stakeholders requiring periodic reassurance
- Keep Informed quadrant — interested but low-power stakeholders deserving regular updates
- Monitor quadrant — peripheral stakeholders requiring minimal engagement
- Engagement plan — communication frequency, format, and key messages per quadrant
**Guiding questions:**
- Have we identified all stakeholders, including those opposed to the initiative?
- Which stakeholders in the "Manage Closely" quadrant are currently underserved in our engagement?
- Who has informal power — reputation, expertise, or social influence — not reflected in formal titles?
- What are the concerns of our most powerful skeptics, and how are we proactively addressing them?
- Which stakeholders could move from supportive to opposed if a key assumption changes?
**Evaluation criteria:**
- Completeness of stakeholder identification across organizational boundaries
- Accuracy of power and interest assessments
- Specificity and appropriateness of tailored engagement plans per quadrant
- Frequency of stakeholder map updates as dynamics shift
- Evidence of proactive engagement converting skeptics to supporters
**Typical use cases:**
- Large-scale product launch stakeholder communication planning
- Organizational change management programs
- Cross-functional product strategy alignment
- External partnership and ecosystem management
**Strengths and limitations:** Stakeholder Mapping prevents the common failure mode of ignoring or underestimating opposition until it becomes an execution blocker, and it ensures that the people with the most power are actively managed rather than passively hoped for. It is especially valuable in large organizations and public sector contexts. Its limitation is that stakeholder dynamics are fluid — maps become stale quickly and require ongoing updating to remain useful.
**Related frameworks:** Four Types of Strategy Stakeholders, Systems Map, Change Management Frameworks, Service Blueprint, Strategy Process Map, OKRs

---

### Lateral Thinking
**Category:** Creativity / Innovation
**Tags:** Edward de Bono, provocation, random entry, challenge assumptions, concept fan, creativity
**How it works:** Lateral Thinking was introduced by Edward de Bono in his 1970 book *Lateral Thinking: Creativity Step by Step* as a deliberate, systematic method for generating creative ideas by challenging established thinking patterns — the dominant "vertical thinking" path of logical, sequential reasoning. De Bono argued that the brain's pattern-recognizing efficiency, while valuable for routine problems, actively prevents creative breakthrough by trapping thinking in established grooves. Lateral Thinking uses specific techniques to escape these grooves: Random Entry (introducing an unrelated random word or image and forcing connections to the problem), Provocation (using "Po" — provocative operations — to state deliberately false or impossible premises and trace their creative implications), Challenge (questioning why things are done the current way), and Concept Fan (broadening problem definition iteratively).
**Dimensions / components:**
- Random Entry — introducing a random stimulus and extracting connections to the problem
- Provocation (Po) — stating impossible or contrary premises to stimulate new directions
- Challenge — questioning the necessity of existing assumptions and processes
- Concept Fan — broadening the problem definition to reveal new solution spaces
- Alternatives — deliberately generating many ways to approach a concept before selecting one
- Stepping stones — using initial provocative ideas as stepping stones to practical concepts
**Guiding questions:**
- What would we do if the opposite of our current approach were true?
- If we connect our problem to a completely unrelated concept [random word], what associations emerge?
- Why do we do this step at all — what would happen if we simply removed it?
- What broader problem does our stated problem sit within — and does reframing at that level reveal new solutions?
- What stepping stone from a provocative idea leads us to a practical, novel concept?
**Evaluation criteria:**
- Movement beyond the initial solution repertoire of the group
- Novelty of ideas generated relative to conventional approaches
- Quality of stepping-stone reasoning from provocative ideas to practical concepts
- Group comfort with deliberate creative discomfort
- Translation rate of lateral thinking outputs into implemented innovations
**Typical use cases:**
- Innovation workshops where conventional thinking has produced only incremental ideas
- Product strategy breakout sessions facing entrenched category conventions
- Creative director sessions for brand and product naming or positioning
- Problem-solving sessions where all obvious solutions have been exhausted
**Strengths and limitations:** Lateral Thinking provides specific, repeatable techniques for escaping established thinking patterns, making creativity a skill rather than an innate talent. Random Entry and Provocation in particular reliably generate ideas that would not emerge from conventional brainstorming. Its limitation is that the techniques feel artificial to many practitioners and require a skilled facilitator to maintain the creative frame and prevent groups from immediately reverting to vertical thinking.
**Related frameworks:** Six Thinking Hats, SCAMPER, Creative Problem Solving, How-Might-We Statements, Design Thinking, First Principles Thinking

---

### Sprint Retrospective and Kaizen
**Category:** Product Management / Continuous Improvement
**Tags:** agile retrospective, continuous improvement, Kaizen, process reflection, team health, learning loop
**How it works:** The Sprint Retrospective is the final ceremony of each Scrum sprint, dedicated to team reflection on process, relationships, and tools — asking what went well, what could be improved, and what specific improvements to implement next sprint. Rooted in the Lean/Toyota Kaizen philosophy (the practice of continuous, incremental improvement involving all team members), retrospectives are the primary organizational learning mechanism for agile teams. Effective retrospectives follow structured formats (Start/Stop/Continue, 4Ls — Liked, Learned, Lacked, Longed For, or Mad/Sad/Glad), generate a short list of specific, owned improvement actions, and begin each subsequent sprint by reviewing whether previous actions were implemented. The retrospective is where team health, psychological safety, and process quality are genuinely addressed.
**Dimensions / components:**
- Retrospective cadence — held at the end of every sprint (1–4 weeks)
- Inspection — examining what happened in the past sprint across process, tools, and relationships
- Adaptation — identifying specific improvement actions to implement in the next sprint
- Retrospective formats — Start/Stop/Continue, 4Ls, Mad/Sad/Glad, Sailboat, etc.
- Action items — 1–3 specific, owned, time-bounded improvement commitments
- Kaizen mindset — every team member contributes to continuous improvement as a shared responsibility
- Psychological safety — the prerequisite for honest retrospective dialogue
**Guiding questions:**
- What specific actions from last retrospective did we actually implement?
- What one process change would most improve our next sprint's quality and team wellbeing?
- Are we surfacing structural problems or only superficial symptoms in our retrospectives?
- Is everyone contributing to retrospectives — or are the same voices dominating?
- Are retrospective action items specific and owned, or vague and collective?
**Evaluation criteria:**
- Implementation rate of previous retrospective actions
- Specificity and ownership clarity of new action items
- Participation breadth across team members
- Evidence of improving team process metrics over consecutive sprints
- Psychological safety level — willingness to raise uncomfortable truths
**Typical use cases:**
- Agile product team sprint closing ceremonies
- Quarterly team health reviews
- Post-mortem and blameless incident analysis in engineering teams
- Team process improvement workshops
**Strengths and limitations:** The Sprint Retrospective, when done well, is the most powerful organizational learning mechanism available to a product team — it creates a direct, rapid feedback loop between team experience and process design. Combined with Kaizen philosophy, it enables continuous, compounding improvement. Its limitation is that poorly facilitated retrospectives become complaint sessions without actionable outputs, and psychological safety deficits prevent teams from surfacing the issues that matter most.
**Related frameworks:** Agile/Scrum, Kaizen, OKRs, Lean UX, Hypothesis-Driven Development, Five Whys

---

### Jobs-to-Be-Done — Forces of Progress Model
**Category:** Customer Discovery / Behavioral Economics
**Tags:** Bob Moesta, push-pull, anxiety, habit, switching behavior, Clay Christensen, demand-side
**How it works:** The Forces of Progress model, developed by Bob Moesta and Chris Spiek of the Re-Wired Group as an extension of the Jobs-to-Be-Done framework, explains the demand-side dynamics of why customers switch from one product to another (or fail to switch despite being aware of alternatives). Four forces act on any purchase or adoption decision: Push (the frustration or dissatisfaction with the current solution that makes customers consider alternatives), Pull (the attraction toward the new solution's promise), Anxiety (fear or uncertainty about adopting the new solution), and Habit (the comfort and inertia of the existing solution). A switch occurs when Push + Pull exceed Anxiety + Habit. The model is used in product development, messaging design, and sales to understand and engineer the decision conditions that drive adoption.
**Dimensions / components:**
- Push — the situational trigger or accumulated frustration with the current solution
- Pull — the attractive promise of the new solution's outcome or benefit
- Anxiety — worries about cost, switching complexity, risk, or the new solution's adequacy
- Habit — the powerful pull of the familiar, the established routine, and social acceptance
- Timeline of events — the sequence of experiences leading up to the decision moment
- Struggling moment — the specific situation that catalyzes the switch consideration
- First thought — the very first alternative considered when the struggling moment occurs
**Guiding questions:**
- What specific struggling moment initiates our customers' consideration of a new solution?
- What specific promises or benefits are pulling customers toward our product?
- What anxieties are preventing interested customers from actually switching?
- How powerful is the habit and social acceptance of the existing solution?
- Are we investing in increasing Pull when we should be reducing Anxiety?
**Evaluation criteria:**
- Quality of demand-side interview research surfacing actual switching experiences
- Accuracy of Force magnitude estimates (Push, Pull, Anxiety, Habit) across customer segments
- Product and messaging design changes made to address identified Force imbalances
- Conversion rate improvements attributable to anxiety-reduction interventions
- Reduction in churn from customers who switched but experienced high post-adoption anxiety
**Typical use cases:**
- Product messaging and positioning design
- Sales process design for high-consideration purchases
- Onboarding design to reduce post-adoption anxiety
- Churn analysis — understanding what tips the Force balance toward cancellation
**Strengths and limitations:** The Forces of Progress model provides the most psychologically grounded framework available for understanding why customers adopt or reject products, going beyond feature comparison to behavioral economics. It is especially powerful for high-consideration and complex sales contexts. Its limitation is that Forces research requires skilled qualitative interviewing (timeline interviews) to surface the actual experiences rather than retrospective rationalizations.
**Related frameworks:** Jobs-to-Be-Done, Customer Development, Empathy Mapping, Behavioral Economics Frameworks, Value Proposition Canvas, Continuous Discovery

---

### Technology Readiness Level (TRL)
**Category:** Innovation / Product Development
**Tags:** NASA, readiness assessment, technology maturation, R&D, gate review, risk management
**How it works:** Technology Readiness Levels (TRL) is a systematic measurement system developed by NASA in the 1970s (formalized by Stan Sadin) and adopted by the U.S. Department of Defense, ESA, and enterprise innovation programs to assess the maturity of a specific technology from conception through deployment. TRL runs on a nine-point scale: TRL 1–3 covers basic research and proof-of-concept; TRL 4–6 covers prototype development and laboratory/environment validation; TRL 7–9 covers system demonstration, qualification, and full operational deployment. TRL enables organizations to make informed investment and gate decisions based on objective maturity evidence rather than inventor optimism. It is widely used in hardware, software, and biomedical innovation portfolios.
**Dimensions / components:**
- TRL 1 — Basic principles observed and reported
- TRL 2 — Technology concept and/or application formulated
- TRL 3 — Analytical and experimental proof of concept
- TRL 4 — Technology validated in lab environment
- TRL 5 — Technology validated in relevant environment
- TRL 6 — Technology demonstrated in relevant environment
- TRL 7 — System prototype demonstration in operational environment
- TRL 8 — System complete and qualified
- TRL 9 — Actual system proven through successful mission operations
**Guiding questions:**
- What is the current TRL of each technology component in our portfolio?
- At which TRL thresholds do we make go/no-go investment decisions?
- What evidence is required to advance from the current TRL to the next?
- Are any technologies being promoted to production use before reaching TRL 7 or 8 validation?
- How do TRL assessments inform our Stage-Gate or portfolio prioritization decisions?
**Evaluation criteria:**
- Objective and documented evidence for each claimed TRL level
- Independent review of TRL assessments to counter inventor optimism
- Alignment between TRL thresholds and portfolio investment decision gates
- Speed of TRL advancement as a technology development efficiency indicator
- Integration of TRL tracking into portfolio management processes
**Typical use cases:**
- Government and defense program technology investment decisions
- Corporate R&D portfolio management in technology-intensive industries
- Innovation portfolio risk assessment and communication
- Technology licensing and M&A due diligence
**Strengths and limitations:** TRL provides an objective, evidence-based language for describing technology maturity that prevents premature scale-up of immature technologies — a common and costly failure mode in innovation programs. It is particularly valuable for cross-organizational communication and portfolio management. Its limitation is that the scale was designed for hardware-centric NASA programs and maps imperfectly onto software, service, and social innovations where "operational environment" is more ambiguous.
**Related frameworks:** Stage-Gate Process, Innovation Ambition Matrix, McKinsey Three Horizons, Assumption Mapping, Lean Canvas, Open Innovation

---

### Agile Roadmapping with Themes
**Category:** Roadmap Prioritization / Product Strategy
**Tags:** theme-based roadmap, strategic themes, outcome-driven, flexibility, stakeholder communication
**How it works:** Theme-based Agile Roadmapping organizes the product roadmap around high-level strategic themes — capability areas or outcome goals — rather than specific features or release dates. Each theme represents a cluster of related customer problems or strategic objectives that the team will invest in over a planning horizon. Within a theme, the specific features or solutions are left flexible, determined by ongoing discovery. This approach communicates direction and priorities clearly to stakeholders while preserving team flexibility to build the best solutions discovered through continuous customer contact. Themes are derived from product strategy and OKRs, giving the roadmap a clear strategic rationale. The format works particularly well for organizations communicating publicly about product direction without committing to specific features.
**Dimensions / components:**
- Strategic themes — high-level problem areas or capability goals (e.g., "Improve onboarding conversion")
- Theme rationale — the business and customer reason for investing in each theme
- Time horizon — now/next/later or quarter-by-quarter theme distribution
- Outcome metrics — measurable goals associated with each theme
- Discovery scope — the customer problems and solutions to be explored within each theme
- Theme prioritization — explicit rationale for theme ordering and resource allocation
- Stakeholder version — simplified theme-level view suitable for external communication
**Guiding questions:**
- Do our themes represent customer problems and strategic outcomes, or product features in disguise?
- Have all themes been explicitly connected to OKRs or strategic priorities?
- Are the specific solutions within each theme left to discovery, or pre-specified?
- Do stakeholders understand that themes represent intent, not committed feature sets?
- How will we measure whether investment in each theme achieved its intended outcomes?
**Evaluation criteria:**
- Outcome-orientation of theme descriptions (problem/goal language vs. feature language)
- Alignment of themes with declared OKRs and strategic priorities
- Balance of themes across near-term delivery and longer-horizon bets
- Stakeholder alignment on theme priorities and their rationale
- Flexibility preserved within themes for discovery to inform specific solutions
**Typical use cases:**
- Public product roadmap communication for SaaS companies
- Annual and quarterly product planning with executive and board stakeholders
- Agile teams replacing feature-specific Gantt roadmaps with flexible direction-setting
- Multi-team program coordination on shared strategic goals
**Strengths and limitations:** Theme-based roadmapping elegantly balances the stakeholder need for strategic clarity with the team's need for discovery flexibility. It prevents premature feature commitment while still communicating meaningful intent. Its limitation is that themes can be too abstract for engineers who need specific stories to plan work, requiring a bridge between theme-level roadmap and sprint-level backlog. It also requires strong facilitation to prevent themes from becoming vague containers for arbitrary work.
**Related frameworks:** Now–Next–Later Roadmap, OKRs, Opportunity Solution Tree, Agile/Scrum, Continuous Discovery, User Story Mapping

---

### Behavioral Design (BJ Fogg's Behavior Model)
**Category:** UX Research / Product Design
**Tags:** BJ Fogg, motivation, ability, prompts, habit formation, persuasive technology, engagement
**How it works:** BJ Fogg's Behavior Model, developed at Stanford's Persuasive Technology Lab and published in *Tiny Habits* (2020), asserts that three elements must converge simultaneously for any behavior to occur: sufficient Motivation (the desire to perform the behavior), sufficient Ability (the ease of performing the behavior — physical, cognitive, financial, social, temporal), and an effective Prompt (a trigger that cues the behavior at the right moment). The model is typically visualized as a graph where the Action Line separates behaviors that occur from those that do not — higher motivation allows harder behaviors (lower ability), and easier behaviors (higher ability) need less motivation. For product teams, the model guides engagement design: increase motivation through emotional value, reduce ability barriers through simplification, and design effective prompts through notifications or environmental cues.
**Dimensions / components:**
- Motivation — the three core motivators: sensation (pleasure/pain), anticipation (hope/fear), belonging (acceptance/rejection)
- Ability — the six elements: time, money, physical effort, mental effort, social deviance, routine
- Prompt — three types: spark (when motivation is low), facilitator (when ability is low), signal (when both are sufficient)
- Action Line — the threshold curve separating behavior occurrence from non-occurrence
- Tiny Habits method — starting with extremely small behaviors to build ability and motivation simultaneously
- Behavior chains — sequences of existing behaviors used as anchors for new habit prompts
**Guiding questions:**
- Is the target behavior failing due to insufficient motivation, insufficient ability, or missing/ineffective prompt?
- What is the smallest version of this behavior that would build momentum toward the full behavior?
- Which of the six ability elements is the highest barrier for our target users?
- What existing behavior in the user's routine could serve as an effective anchor for our prompt?
- Are our product prompts arriving at the right moment — when motivation and ability are both sufficient?
**Evaluation criteria:**
- Accuracy of diagnosis (motivation vs. ability vs. prompt as the binding constraint)
- Specificity of ability reduction interventions (targeting the right ability element)
- Prompt timing effectiveness relative to user behavioral context
- Behavior completion rate improvements following design interventions
- Long-term habit formation evidence (behavior becoming automatic without prompts)
**Typical use cases:**
- Onboarding design to establish habit-forming product engagement
- Health and wellbeing app behavior change design
- Notification and prompt strategy optimization for consumer apps
- Engagement loop design for social and content platforms
**Strengths and limitations:** Fogg's Behavior Model provides a clear, actionable diagnostic framework that helps product teams identify exactly why users are not completing desired behaviors — an analysis that most teams skip in favor of adding features. It is particularly powerful for engagement and habit-formation design. Its limitation is that it has been criticized for enabling manipulative design when motivation is artificially amplified rather than genuine — ethical application requires prioritizing genuine user benefit.
**Related frameworks:** Growth Loop Model, AARRR, Habit Loop (Duhigg), Jobs-to-Be-Done, Empathy Mapping, Jobs Forces of Progress

---

### Minimal Viable Product (MVP) Taxonomy
**Category:** Product Discovery / Lean Startup
**Tags:** MVP types, concierge, Wizard of Oz, smoke test, landing page, fidelity ladder
**How it works:** While the MVP concept originates with Lean Startup, practical application requires clarity about which type of MVP to use for which learning objective. The MVP Taxonomy organizes the spectrum of MVP types by their purpose, fidelity, and cost: Smoke Test (landing page or fake door to measure demand before building anything), Concierge MVP (manually delivering the full service to a small cohort), Wizard of Oz MVP (automating the appearance while humans do the actual work), Piecemeal MVP (combining existing tools and services into a new value delivery configuration), Single-Feature MVP (a fully built but scope-minimized version of one core function), and Pilot MVP (a time- and scope-bounded early access program). Choosing the right MVP type prevents over-building when a simpler test would generate equivalent learning.
**Dimensions / components:**
- Smoke Test — demand validation through pre-launch landing page or signup before any product is built
- Concierge MVP — humans manually delivering the product experience for early adopters
- Wizard of Oz MVP — simulated automation backed by human operators
- Piecemeal MVP — reconfigured existing tools (Zapier, Airtable, Google Forms) delivering new value
- Single-Feature MVP — a fully functioning but narrowly scoped product core
- Pilot MVP — bounded early access program with real users
- Fidelity ladder — matching MVP type to the specific learning hypothesis
**Guiding questions:**
- What is the specific hypothesis this MVP must test — and what is the minimum fidelity to test it?
- Would a Smoke Test or Concierge MVP generate the same learning as a built product at a fraction of the cost?
- Who are the early adopters willing to tolerate the constraints of a low-fidelity MVP?
- What does success look like for this MVP — what behavioral signal would give us confidence to invest further?
- After this MVP, what is the next cheapest test — not the full product?
**Evaluation criteria:**
- MVP type appropriateness to the learning hypothesis
- Cost and time to build relative to expected learning value
- Behavioral signal quality generated (not just verbal feedback)
- Team willingness to stop or pivot based on negative MVP outcomes
- Learning velocity across sequential MVP iterations
**Typical use cases:**
- Startup product validation before engineering team assembly
- Corporate new product concept validation before investment approval
- Continuous discovery assumption testing
- Feature validation before full development sprint commitment
**Strengths and limitations:** The MVP Taxonomy prevents the common misapplication of MVP as "minimum feature product" (a full product with fewer features) and clarifies that the right MVP type depends entirely on what question is being answered. It dramatically reduces validation costs by matching fidelity to learning need. Its limitation is that customers experiencing low-fidelity MVPs may form lasting negative impressions of the brand or the team, requiring careful communication about the MVP's intentional limitations.
**Related frameworks:** Lean Startup, Assumption Mapping, Customer Development, Hypothesis-Driven Development, Rapid Prototyping, Problem-Solution Fit

---
