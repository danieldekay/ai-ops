---
name: thinking-frameworks
description: "Decision taxonomy for selecting the right thinking framework(s) for any problem. Routes by problem type, time horizon, stakeholder complexity, and evidence base. 505 frameworks across 8 domains, split into 44 sub-files (<500 lines each). Use when asked 'which framework should I use for X', 'how should I think about Y', or any complex problem-solving, strategy, analysis, or decision task. Use the navigation patterns below — never read all files at once."
---

# Thinking Frameworks — Selection Taxonomy

505 frameworks · 8 domains · 44 reference files (all ≤500 lines)

---

## Navigation: Find Without Reading Everything

**Rule: never load more than 2 files per task. Use lookup first.**

### Lookup Strategy (fastest → slowest)

| Method | When | Command |
|--------|------|---------|
| **Master index** | Know domain, want file | `ctx_read("references/00-master-index.md", mode="full")` |
| **Comment headers** | Scan which part has a framework | `head -3 references/0N*.md` or see table below |
| **Heading scan** | Confirm framework is in a file | `ctx_read(file, mode="signatures")` |
| **grep exact name** | Know exact framework name | `grep -rl "^### Framework Name" references/` |
| **grep keyword** | Partial name / concept | `grep -ri "keyword" references/ -l` |
| **Full read** | Actually using a framework | `ctx_read(file, mode="task")` or `mode="full"` |

### lean-ctx Patterns

```
# Scan headings only (~5% tokens vs full read)
ctx_read("references/01a-strategy-consulting.md", mode="signatures")

# Find which files mention a concept
ctx_search("wardley", "references/")

# Task-relevant sections only (IB-filtered)
ctx_read("references/02b-decision-making-mental-models.md", mode="task")

# Scan all comment headers for a domain fast
ctx_search("<!-- Frameworks in this file:.*lean", "references/")
```

### Grep Patterns

```bash
# Exact framework lookup → get filename
grep -rl "^### Porter's Five Forces" skills/thinking-frameworks/references/

# List all frameworks in one domain
grep "^### " skills/thinking-frameworks/references/02*.md

# Keyword search → list matching files
grep -ril "cognitive bias" skills/thinking-frameworks/references/

# Read just comment headers for a domain (no content)
head -3 skills/thinking-frameworks/references/03*.md
```

---

## Step 1 — 5-Question Diagnostic

| # | Question | Options |
|---|----------|---------|
| 1 | **Primary problem nature** | strategic/market · operational/execution · analytical/decision · systemic/emergent · human/behavioral · innovation/product · risk/compliance · technical/scientific |
| 2 | **Time horizon** | immediate (<1w) · tactical (1w–3mo) · strategic (3mo–3yr) · long-range (3yr+) |
| 3 | **Evidence available** | none/anecdotal · partial · substantial · high-fidelity data |
| 4 | **Decision reversibility** | exploratory/low-stakes · reversible · irreversible/high-stakes · ongoing/iterative |
| 5 | **Stakeholder scope** | individual · small team · organization · ecosystem/market |

---

## Step 2 — Domain Routing Table

| Problem Nature | Files | Go-to Frameworks |
|----------------|-------|-----------------|
| **Strategic / Market** | `01a–01g` | Porter's Five Forces, SWOT, BCG Matrix, PESTEL, Value Chain Analysis, Issue Tree, Scenario Planning, MECE |
| **Decision / Analytical** | `02a–02g` | Cynefin, Decision Trees, Bayesian Updating, Type 1/Type 2, Second-Order Thinking, Inversion, Weighted Decision Matrix |
| **Systemic / Emergent** | `03a–03f` | Causal Loop Diagram (CLD), Systems Archetypes, Iceberg Model, Wardley Mapping, Tipping Points, Viable System Model |
| **Innovation / Product** | `04a–04f` | JTBD, Lean Startup, Double Diamond, Opportunity Solution Tree (OST), Business Model Canvas, North Star Metric, Design Sprint |
| **Risk / Compliance / Ops** | `05a–05f` | FMEA, Bow-Tie, ISO 31000, STRIDE, Monte Carlo, RCA, NIST CSF |
| **Human / Behavioral** | `06a–06f` | COM-B, Dual Process Theory, Emotional Intelligence, Habit Loop, Motivational Interviewing, SCARF |
| **Technical / Scientific** | `07a–07d` | Bayesian Networks, NIST AI RMF, Chaos Engineering, FAIR, SRE, Falsificationism |
| **Advanced Engineering / Epistemic** | `08a–08b` | STAMP/STPA, TRIZ, Axiomatic Design, HAZOP, Human Reliability Analysis |
| **Name lookup only** | `00-master-index.md` | Full alphabetical index — identify domain + file from any name |

---

## Step 3 — Cross-Cutting Combinations

| Problem Pattern | Frameworks | Files |
|-----------------|-----------|-------|
| Market entry with uncertainty | Porter's Five Forces + Scenario Planning + CAGE | `01a`, `03d` |
| Root cause → fix broken process | 5 Whys → FMEA → PDCA | `01b`, `05a` |
| Executive communication | Pyramid Principle + SCQA Narrative + TOSCA | `01b`, `01f` |
| Product idea validation | JTBD + Lean Canvas + Problem-Solution Fit + A/B Testing | `04a`, `04b` |
| Competing initiatives | RICE + Eisenhower Matrix + Cost of Delay + MoSCoW | `02a`, `04a` |
| Organizational change | Kotter's 8-Step + McKinsey 7-S + Influence Model | `01d`, `01e` |
| High-stakes irreversible decision | Pre-Mortem + Red Team + Type 1/Type 2 + Bayesian Updating | `02a`, `02b` |
| Complex system intervention | CLD + Systems Archetypes + Leverage Points (Meadows) | `03a`, `03b` |
| Cybersecurity risk posture | STRIDE + NIST CSF 2.0 + MITRE ATT&CK + FAIR | `05a`, `05b` |
| Team / culture shift | Tuckman's + SCARF + Psychological Safety + Cynefin | `02a`, `06a` |
| AI/ML system risk | NIST AI RMF + Bayesian Networks + Falsificationism | `07a`, `07c` |
| Long-range foresight | Three Horizons + Causal Layered Analysis + Backcasting | `03d`, `03e` |
| Negotiation / conflict | Interest-Based Negotiation + Dual-Concern Model + NVC | `06c` |
| Customer discovery | JTBD + Contextual Inquiry + Empathy Mapping + Value Proposition Canvas | `04a`, `04c` |
| Financial distress | Altman Z-Score + DuPont Analysis + DCF Valuation | `01b`, `05e` |

---

## Step 4 — Selection Heuristics

1. **Unknown problem structure** → Issue Tree (MECE) before any analysis
2. **Communication to leadership** → Pyramid Principle / SCQA; answer first, evidence second
3. **Feedback loops suspected** → CLD; if confirmed, apply Systems Archetypes
4. **Reversible + fast decision** → OODA Loop or ICE Scoring; skip heavy analysis
5. **Irreversible + high-stakes** → Pre-Mortem + Red Team + Bayesian Updating
6. **Root cause needed** → 5 Whys first; escalate to FMEA only if systemic/safety-critical
7. **Innovation needed** → Diverge with JTBD / How-Might-We, converge with OST
8. **Unknown market** → PESTEL + Porter's Five Forces + Customer Segmentation in sequence
9. **Human resistance** → COM-B + Motivational Interviewing before structural solutions
10. **Competing hypotheses** → Bayesian Updating; weak evidence → Delphi or Superforecasting

---

## Step 5 — Anti-Patterns

| Anti-pattern | Why it fails | Better alternative |
|---|---|---|
| SWOT as sole strategic tool | No causality, no prioritization | Issue Tree + Porter's Five Forces |
| Design Sprint before validation | Builds wrong thing faster | JTBD + Customer Discovery first |
| FMEA on complex adaptive systems | Assumes linear causation | CLD + Systems Archetypes |
| Eisenhower for multi-stakeholder decisions | Ignores dependencies, politics | RICE + Stakeholder Mapping |
| Single framework for systemic problems | Misses cross-domain dynamics | 3-framework combo: diverge + analyze + execute |
| Mental models as substitutes for evidence | Amplifies confirmation bias | Bayesian Updating + Devil's Advocacy |
| Six Sigma on creative/innovative work | Kills variance needed for innovation | Lean Startup + Design Sprint |

---

## Agent Usage Protocol

1. **Run diagnostic** — classify problem on all 5 axes (Step 1)
2. **Route to domain** — use routing table or grep `00-master-index.md`
3. **Find the right part** — `head -3 references/0Nx-*.md` to scan comment headers
4. **Load minimally** — `ctx_read(file, mode="signatures")` to confirm, `mode="task"` to use
5. **Check cross-cutting patterns** (Step 3) for multi-domain problems
6. **Compose 3 frameworks**: divergent (explore) + analytical (structure) + execution (act)
7. **Cite selection**: name the frameworks + one-sentence rationale each

---

## Reference Files — Part Content Map

Each file begins with `<!-- Frameworks in this file: ... -->` on line 3. Read that line to identify whether a framework is in a file before loading the full content.

| File | Domain | Frameworks (first few) |
|------|--------|------------------------|
| `00-master-index.md` | All | Alphabetical index |
| `01a` | Strategy | Porter's Five Forces, SWOT, PESTEL, Ansoff, AFI, Blue Ocean, Balanced Scorecard, OGSM, JTBD, Scenario Planning, OKRs, Hoshin Kanri, MECE, Issue Tree |
| `01b` | Strategy | Hypothesis-Driven, Pyramid Principle, RCA (5 Whys), Design Thinking, McKinsey Problem-Solving, First Principles, A3, Profitability, 3Cs, Value Chain, VRIO, CLV, EBITDA Bridge, DuPont |
| `01c` | Strategy | Customer Segmentation, Market Sizing, EBIT/EBITDA, Revenue Growth Mgmt, Pricing (3Cs), Value-Based Pricing, Price Elasticity, Van Westendorp, Dynamic Pricing, M&A, Porter's Diamond, Porter's Generic Strategies |
| `01d` | Strategy | Modes of Entry, GTM, MVP Strategy, Competitive Benchmarking, BCG, GE-McKinsey 9-Box, Three-Horizon, Strategic Group Analysis, Ecosystem/Platform Strategy, Growth Flywheel, Capital Allocation, Portfolio Diversification, Real Options |
| `01e` | Strategy | Competing Values, Jobs Architecture, Galbraith Star, McKinsey 7-S, Kotter's 8-Step, Influence Model, Psychological Safety, RACI, OODA Loop, SMART Goals, Deliberate Practice, Executive Briefing, Pre-Mortem |
| `01f` | Strategy | Conjoint Analysis, SCQA Narrative, Stakeholder Communication, Service Design Blueprint, Storylining, TOSCA, CAGE, Subscription/Freemium Pricing, Pareto (80/20), S-Curve Innovation, Beachhead Market, Socratic Method |
| `01g` | Strategy | Devil's Advocate/Red Team, Disruptive Innovation (Christensen), Value Stream Mapping, After-Action Review, Customer Journey Mapping, Competitor Response Analysis |
| `02a` | Decision | Second-Order Thinking, Inversion, Cynefin, Type 1/Type 2, SPADE, Pre-commitment/Ulysses, Regret Minimization, Mental Model Lattice (Munger), Circle of Competence, Probabilistic Thinking |
| `02b` | Decision | Dual Process Theory (S1/S2), Recognition-Primed Decision, Six Thinking Hats, Socratic Method, Steel-Manning, Devil's Advocacy, Confirmation Bias Debiasing, Anchoring Debiasing, Framing Effect, Status Quo Debiasing, Sunk Cost Debiasing |
| `02c` | Decision | Overconfidence Debiasing, Prospect Theory, Nudge Design, EAST, Bayesian Updating, Superforecasting, Reference Class Forecasting, Delphi Method, Prediction Markets |
| `02d` | Decision | Decision Trees, Weighted Decision Matrix, RICE, ICE Scoring, MoSCoW, Eisenhower Matrix, Value vs Effort, Pareto Analysis, Cost-Benefit Analysis, Cost of Delay |
| `02e` | Decision | Theory of Constraints, DACI, DARE, Force Field Analysis, Game Theory, Red Team, Scenario Analysis, Sensitivity Analysis, Monte Carlo, Causal Impact Analysis, Ladder of Inference, Double-Loop Learning |
| `02f` | Decision | Causal Loop Diagramming, Leverage Points, Modus Ponens/Tollens, Abductive Reasoning, Analogical Reasoning, Argumentation Mapping, Toulmin Model, Falsificationism |
| `02g` | Decision | Opportunity Space Mapping, Fermi Estimation, Moral Intuition Pumps, Hanlon's Razor, Occam's Razor |
| `03a` | Systems | Causal Loop Diagram, Stock-and-Flow, Behavior Over Time Graph, Systems Archetypes, Iceberg Model, System Dynamics (Forrester), Feedback Control, Reinforcing/Balancing Feedback, Policy Structure Diagram, Beer Game |
| `03b` | Systems | Complex Adaptive Systems, Emergence, Agent-Based Modeling, Fitness Landscape, Power Laws, Tipping Points, Panarchy, Living Systems Theory, Autopoiesis, Viable System Model, Ashby's Law, Network Theory |
| `03c` | Systems | Soft Systems Methodology (SSM), CATWOE, Rich Pictures, Group Model Building, Senge's Five Disciplines, Social-Ecological Systems, Doughnut Economics, Planetary Boundaries, Ecological Resilience |
| `03d` | Systems | Resilience Thinking, Adaptive Management, Transformative Resilience, Transition Management, Three Horizons, Backcasting, Futures Wheel, Futures Triangle, Horizon Scanning, Causal Layered Analysis (CLA), Shell Scenario Planning, Two-Axes Scenario Matrix |
| `03e` | Systems | STEEP/STEEPS, Wild Cards/Black Swans, Wind Tunneling, Wardley Mapping, Biomimicry, Counterfactual Reasoning, Social Network Analysis (SNA), 5 Whys (systems), Fault Tree Analysis, FMEA (systems) |
| `03f` | Systems | Strategic Foresight, Double Diamond Design, Systems Map |
| `04a` | Product | Lean Startup, Double Diamond, Business Model Canvas, Value Proposition Canvas, RICE, JTBD, Jobs Innovation Theory, JTBD Forces/ODI, Design Sprint, Agile/Scrum, Shape Up, Lean UX, Agile Roadmapping |
| `04b` | Product | Lean Canvas, Customer Development, Problem-Solution Fit, Product-Market Fit, AARRR, Growth Loop, North Star Metric, Lean Analytics, Feature Flagging, A/B Testing, Hypothesis-Driven Dev, Continuous Discovery, OST, User Story Mapping |
| `04c` | Product | Empathy Mapping, Persona Development, Contextual Inquiry, Diary Studies, Experience Sampling, Think-Aloud, Heuristic Evaluation, Cognitive Walkthrough, Affinity Mapping, How-Might-We, POV Statement, Service Blueprint |
| `04d` | Product | Innovation Ambition Matrix, Ten Types of Innovation (Doblin), Open Innovation, SCAMPER, Lateral Thinking, CPS, Crazy 8s, Structured Innovation, 10X Thinking, Business Model Navigator, Rapid Prototyping |
| `04e` | Product | Now–Next–Later Roadmap, Impact–Effort Matrix, WSJF, McKinsey Three Horizons, Stage-Gate, TRL, Stakeholder Mapping, Sprint Retrospective/Kaizen, NPS, Pirate Funnel, Behavioral Design (BJ Fogg) |
| `04f` | Product | MVP Taxonomy, Five Whys (product), Strategy Process Map (IDEO) |
| `05a` | Risk | ISO 31000, COSO ERM, COSO Internal Control, FAIR, ISO/IEC 27001, NIST CSF 2.0, NIST RMF, NIST SP 800-53, CIS Controls v8, ISO/IEC 27005, NIST AI RMF, Zero Trust |
| `05b` | Risk | STRIDE, PASTA, DREAD, OCTAVE, Cyber Kill Chain, MITRE ATT&CK, Bow-Tie, FMEA, FTA, TARA, Enterprise Risk Appetite, KRI, ISO 22301, GRC |
| `05c` | Risk | HIPAA, PCI DSS, GDPR, SOC 2, SOX/ICFR, COBIT 2019, HITRUST CSF, ITIL 4, G20/OECD Governance, King IV, PRINCE2, PMBOK Risk |
| `05d` | Risk | Six Sigma (DMAIC), Lean Manufacturing, Kaizen, TQM, PDCA, ISO 9001, BPM, Reliability-Centered Maintenance, SRE, Chaos Engineering, EVM, Three Lines of Defense |
| `05e` | Risk | DCF Valuation, Financial Statement Analysis, DuPont, Altman Z-Score, Credit Risk (PD/LGD), Operational Risk (Basel), IFRS 9/CECL, VaR, ALM, Earnings Quality, Supply Chain Risk, TPRM |
| `05f` | Risk | Enterprise Risk Quantification, OKR (risk), RCSA |
| `06a` | Learning | Bloom's Taxonomy, SOLO Taxonomy, Constructive Alignment, Gagné's Nine Events, ZPD, Kolb's Cycle, Mastery Learning, UbD, Metacognition, Self-Regulated Learning, Spaced Repetition, Deliberate Practice, Cognitive Load Theory |
| `06b` | Learning | Communities of Practice, SECI Model, PKM, Zettelkasten, Sensemaking (Weick), Growth Mindset, Self-Efficacy, Self-Determination Theory, Sociocultural Theory, Universal Design for Learning (UDL), Flow Theory |
| `06c` | Learning | Dual-Concern Negotiation, Interest-Based Negotiation (Fisher/Ury), Principled Negotiation/ZOPA, Hostage Negotiation, NVC, Active Listening, Rhetorical Triangle, Storytelling, Crucial Conversations, Socratic Questioning, Motivational Interviewing |
| `06d` | Learning | Emotional Intelligence (Goleman), SCARF, Transactional Analysis, Attribution Theory, Cognitive Dissonance, Executive Function, Polyvagal Theory, COM-B Model, Habit Loop, Nudge Theory, Transtheoretical Model, CBT Framework |
| `06e` | Learning | Transformational Leadership, Servant Leadership, Authentic Leadership, Situational Leadership, Tuckman's Stages, Psychological Safety, Just Culture, Intercultural Competence, Moral Foundations Theory, Care Ethics, Stakeholder Ethics, Appreciative Inquiry, ACT |
| `06f` | Learning | Getting Things Done (GTD), Pomodoro, Cynefin (leadership) |
| `07a` | Technical | PAC Learning, VC Dimension, Bayesian Inference Cycle, MDL, Kolmogorov Complexity, Statistical Learning Theory, Rademacher Complexity, PAC-Bayes |
| `07b` | Technical | Bayesian Networks, Markov Decision Processes, Monte Carlo (technical), Causal Inference (Pearl), Structural Causal Models, DAGs, Sensitivity Analysis (technical), ANOVA, Reproducibility Framework |
| `07c` | Technical | NIST AI RMF, AI Fairness/Bias Frameworks, XAI, Chaos Engineering, SRE, Threat Intelligence Kill Chain, Schema-on-Read/Write, Sociotechnical Systems (STS) |
| `07d` | Technical | STRIDE (technical), PASTA (technical) |
| `08a` | Advanced | STAMP/STPA, HAZOP, Human Reliability Analysis, Axiomatic Design, TRIZ, Systems Engineering V-Model, Interface Analysis, Data Quality / Research Data Mgmt, Safety Case Framework, Technical Debt Framework |
| `08b` | Advanced | Technical Reasoning / Philosophy of Science, Epistemic Frameworks for AI, Engineering Tradeoff Analysis, Systems Design Methodology |
