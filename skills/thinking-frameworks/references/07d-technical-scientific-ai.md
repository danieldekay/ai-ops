## Technical, Scientific, AI, and Research Frameworks — Part 4/4

<!-- Frameworks in this file: Schema-on-Read vs. Schema-on-Write Decision, Sociotechnical Systems (STS) Design -->

### Schema-on-Read vs. Schema-on-Write Decision

**Category:** Data Engineering / Technical Problem Solving

**Tags:** data lake, data warehouse, schema evolution, ETL, ELT, data governance

**How it works:** The Schema-on-Read vs. Schema-on-Write decision framework guides the fundamental architectural choice of where and when data structure is enforced in a data pipeline. **Schema-on-Write** (traditional data warehouse model) requires data to conform to a predefined schema at ingestion time — transformations and validations occur before data is stored, ensuring consistency but reducing flexibility. **Schema-on-Read** (data lake model) stores raw data in its native format and applies structure only at query time — enabling rapid ingestion of diverse, evolving data at the cost of deferred quality enforcement and potentially inconsistent consumer experiences. The framework extends to ELT (Extract-Load-Transform, schema-on-read philosophy) vs. ETL (Extract-Transform-Load, schema-on-write philosophy), and informs governance choices about who controls data contracts, how schema evolution is handled, and what the quality–flexibility trade-off should be for each data domain.

**Dimensions / components:**
- **Schema-on-Write:** schema enforced at ingestion; high query performance, strong governance, low flexibility.
- **Schema-on-Read:** schema applied at query time; high ingestion flexibility, potentially inconsistent semantics.
- **ETL (Extract-Transform-Load):** transformation before storage; enforces conformity upstream.
- **ELT (Extract-Load-Transform):** raw loading then in-database transformation; leverages scalable compute.
- **Schema registry:** centralized schema versioning (e.g., Confluent Schema Registry) for streaming systems.
- **Schema evolution policies:** backward/forward compatibility rules governing how schemas can change.
- **Data contract:** formal agreement between data producer and consumer on schema, quality, and latency.

**Guiding questions:**
- Is the data's schema stable and well-understood at ingestion time, or is it expected to evolve rapidly?
- Who are the primary consumers — analytical queries (favoring schema-on-write) or exploratory data science (favoring schema-on-read)?
- What is the cost of a schema mismatch being discovered at query time rather than at ingestion?
- Is the volume and velocity of data too high for synchronous transformation at ingestion (favoring ELT)?
- Does the regulatory or compliance requirement mandate schema validation at the point of data receipt?
- Is a schema registry appropriate for managing schema evolution across multiple producer–consumer pairs?

**Evaluation criteria:**
- The choice aligns with the primary use case: structured analytics vs. exploratory flexibility.
- Schema evolution policy is defined and enforced — accidental breaking changes are prevented.
- Data quality SLAs can be honored under the chosen approach.
- Consumer query performance is acceptable under the schema-on-read interpretation cost.
- Data contracts between producers and consumers are formally specified and versioned.

**Typical use cases:**
- Choosing between a data lake and a data warehouse for a new analytical capability.
- Designing a streaming data ingestion pipeline with schema evolution requirements.
- Migrating from ETL-heavy legacy pipelines to ELT on cloud data warehouse platforms (Snowflake, BigQuery).
- Governance design for a Data Mesh where domain teams own their data product schemas.
- ML feature store design: determining where feature transformations are materialized.

**Strengths and limitations:** The framework forces an explicit, justified decision on a dimension that is often left implicit until production failures occur. Schema-on-write provides stronger guarantees for governed, well-understood domains; schema-on-read enables the data lake agility that exploratory use cases require. The hybrid approach (schema-on-read with a schema registry and data contracts) is increasingly adopted. The main challenge is that schema-on-read deferral of problems creates technical debt in data quality that compounds over time. Organizations frequently migrate from schema-on-read back toward enforced schemas as analytical maturity grows.

**Related frameworks:** Data Mesh, Lambda Architecture, CAP Theorem Trade-off Analysis, Exploratory Data Analysis Protocol, Architecture Decision Records

---

### Sociotechnical Systems (STS) Design

**Category:** Technical Problem Solving / Organizational Design / AI/ML

**Tags:** joint optimization, human factors, organizational design, work systems, technology–people fit

**How it works:** Sociotechnical Systems theory, [originated by Eric Trist and colleagues at the Tavistock Institute in the 1950s](https://en.wikipedia.org/wiki/Sociotechnical_system) through landmark coal mining studies, holds that effective work systems require simultaneous joint optimization of two interacting subsystems: the **technical system** (tools, processes, machines, algorithms, data) and the **social system** (people, roles, team structures, culture, and incentives). Neither subsystem can be optimized independently without degrading overall system performance — a technically superior system that ignores human factors routinely fails in deployment, while social improvements alone cannot compensate for fundamental technical inadequacy. Applied to contemporary AI and software deployments, STS design explicitly evaluates how algorithmic systems interact with human decision-makers, team structures, cognitive load constraints, and organizational culture, preventing the recurring failure pattern of technically correct systems that are misaligned with how work actually flows in practice.

**Dimensions / components:**
- **Technical subsystem:** hardware, software, algorithms, data, and automated processes.
- **Social subsystem:** people, skills, roles, team structure, culture, and informal communication patterns.
- **Joint optimization:** design iterations that explicitly co-evolve both subsystems, not sequentially.
- **Boundary management:** identification and design of handoff points between human and automated decision-making.
- **Minimum critical specification:** prescribing only the constraints necessary — leaving implementation flexibility to the social system.
- **Requisite variety:** the social system must have sufficient capability range to handle the variety produced by the technical system.
- **Open system perspective:** the work system is embedded in a larger environment that creates demands and constraints.

**Guiding questions:**
- Have both technical and social dimensions been analyzed together, or has technical design preceded social design?
- Where are the human–automation handoff points, and are they designed for human cognitive capabilities?
- Does the algorithmic system generate variety (decision volume, complexity) that exceeds human operators' capacity to manage?
- What organizational incentives and culture exist around the technical system — do they align with intended use?
- Are affected workers and stakeholders involved in system design, or are systems imposed on them?
- What informal work practices have emerged around the technical system that the design does not account for?

**Evaluation criteria:**
- System design documentation explicitly addresses both technical and social subsystem requirements.
- Human operators have been involved in design through participatory design methods.
- Workload analysis confirms that algorithmic output volume does not exceed human oversight capacity.
- Performance metrics measure both technical KPIs and human well-being and skill development indicators.
- Post-deployment review assesses emergence of workarounds, indicating design–reality misalignment.

**Typical use cases:**
- AI-assisted clinical decision support: designing the human–AI collaboration model, not just the algorithm.
- Autonomous vehicle human factors: determining appropriate driver engagement requirements.
- DevOps organizational design: aligning team topology with microservice boundaries.
- Manufacturing automation: designing human roles alongside robotic process automation.
- AI governance: structuring human review processes for high-stakes algorithmic decisions.

**Strengths and limitations:** STS design prevents the most common failure mode of technical systems — building tools that are technically capable but organizationally inoperable. It integrates organizational design, human factors, and technology in a single evaluative frame. Limitations include the difficulty of quantifying social system properties — STS analysis is often qualitative and context-specific, resisting the precision engineers prefer. The theory was developed in manufacturing contexts and requires adaptation for software-intensive and AI-driven systems. Full joint optimization requires interdisciplinary teams that are rare in practice. Without organizational authority to implement social system changes, technical designers cannot achieve joint optimization unilaterally.

**Related frameworks:** Data Mesh, Event Storming, Architecture Decision Records, Epistemic Humility Ladder, Red Team / Blue Team Adversarial Review
