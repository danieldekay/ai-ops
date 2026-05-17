## Risk, Operations, Finance, and Reliability — Part 2/6

<!-- Frameworks in this file: MITRE ATT&CK Framework, Cyber Kill Chain, STRIDE Threat Modeling Framework, PASTA — Process for Attack Simulation and Threat Analysis, DREAD Threat Severity Rating Model, CIS Controls Version 8, ISO/IEC 27005 Information Security Risk Management, NIST AI Risk Management Framework (AI RMF 1.0), COBIT 2019 (Control Objectives for Information and Related Technology), SOX — Sarbanes-Oxley Act Internal Control Framework, GRC Framework — Governance, Risk, and Compliance Integration, G20/OECD Principles of Corporate Governance, Enterprise Risk Appetite Framework, PCI DSS — Payment Card Industry Data Security Standard -->

### MITRE ATT&CK Framework
**Category:** Cybersecurity Risk
**Tags:** threat intelligence, adversary tactics, techniques, procedures, detection, red team
**How it works:** MITRE ATT&CK (Adversarial Tactics, Techniques, and Common Knowledge) is a globally accessible knowledge base of real-world adversary behaviors curated by MITRE and drawn from threat intelligence, incident reports, and security research. The framework organizes adversary behaviors into a matrix of Tactics (the "why" — adversary goals such as Initial Access, Persistence, Privilege Escalation) and Techniques (the "how" — specific methods used to achieve tactical goals). Sub-techniques provide additional specificity. ATT&CK matrices exist for Enterprise (Windows, macOS, Linux, cloud, containers), Mobile, and ICS environments. Security teams use ATT&CK for threat modeling, detection gap analysis, red team planning, threat intelligence enrichment, and SOC capability assessment. The framework is continuously updated based on new threat intelligence, making it a living repository of current adversary behavior.
**Dimensions / components:**
- Tactics (14 enterprise tactics: Reconnaissance through Impact)
- Techniques and sub-techniques (hundreds of specific adversary behaviors)
- Procedure examples (documented use of techniques by named threat groups)
- Mitigations (recommended defensive measures per technique)
- Data sources (telemetry required to detect each technique)
- Groups and Software (documented threat actor and malware profiles)
**Guiding questions:**
- Which ATT&CK techniques are most relevant given the organization's threat landscape and sector?
- Are detection capabilities mapped against ATT&CK to identify coverage gaps?
- Do red team exercises test the organization's ability to detect and respond to priority techniques?
- How does the organization's security posture compare to techniques used by named threat groups targeting its sector?
- Are mitigations implemented for high-priority techniques identified in threat intelligence?
**Evaluation criteria:**
- Coverage breadth of detection capabilities mapped against ATT&CK matrix
- Frequency and quality of ATT&CK-based threat intelligence enrichment
- Red team and purple team exercise alignment with ATT&CK technique coverage
- Gap closure rate between identified detection weaknesses and remediation
- Integration of ATT&CK into SIEM detection engineering and SOC playbooks
**Typical use cases:**
- SOC detection engineering and alert coverage gap analysis
- Red team and purple team exercise planning and reporting
- Threat intelligence program structuring and normalization
- Security product evaluation against technique coverage
- Incident response playbook development aligned with adversary techniques
**Strengths and limitations:** ATT&CK provides a common vocabulary for red and blue teams that significantly improves communication and shared understanding of adversary behavior. Its grounding in real-world observations rather than theoretical models gives it high operational credibility. The framework's broad adoption has driven a rich ecosystem of tools, integrations, and community contributions. Limitations include the risk that organizations optimize for ATT&CK coverage rather than genuine risk reduction, and the framework's breadth can be overwhelming without prioritization based on threat intelligence. Coverage is also stronger for Windows environments than some cloud-native scenarios.
**Related frameworks:** NIST CSF, TARA, STRIDE, Diamond Model of Intrusion Analysis, Kill Chain, D3FEND

---

### Cyber Kill Chain
**Category:** Cybersecurity Risk
**Tags:** intrusion analysis, adversary lifecycle, detection, Lockheed Martin, threat modeling
**How it works:** The Cyber Kill Chain, developed by Lockheed Martin and published in a 2011 Intelligence-Driven Computer Network Defense paper, models a targeted cyberattack as a seven-phase sequential chain from initial reconnaissance through final action on objectives. The framework borrows the military concept of a "kill chain" — interrupting any phase of an adversary's attack chain can disrupt the entire intrusion. Defenders use the model to understand where in the attack lifecycle their detection and response capabilities can most effectively break the chain, and to prioritize investments in detection and prevention at earlier phases where adversary cost is highest. The model is particularly useful for analyzing advanced persistent threat (APT) campaigns and designing intelligence-driven defenses. Its linear model represents a useful simplification for security teams building detection coverage, though modern attacks increasingly bypass earlier stages through trusted access.
**Dimensions / components:**
- Reconnaissance (passive and active information gathering)
- Weaponization (coupling exploit with backdoor payload)
- Delivery (transmitting the weapon to the target environment)
- Exploitation (triggering the exploit against a vulnerability)
- Installation (installing remote access tool or backdoor)
- Command and Control (C2 channel established to compromised system)
- Actions on Objectives (data exfiltration, destruction, or lateral movement)
**Guiding questions:**
- At which Kill Chain phases does the organization currently have detection capability?
- Which phases represent the greatest opportunity to disrupt adversary campaigns cost-effectively?
- Are early-phase indicators (reconnaissance, weaponization) being monitored through threat intelligence?
- How quickly can the organization detect and respond at each phase to minimize dwell time?
- Are defensive investments prioritized to deny adversaries repeated access at phases they favor?
**Evaluation criteria:**
- Detection coverage across all seven phases
- Mean time to detect at each phase in red team exercise simulations
- Intelligence-collection program coverage of early-phase indicators
- Response playbook completeness per Kill Chain phase
- Correlation of Kill Chain phase detections with threat intelligence on targeted campaigns
**Typical use cases:**
- APT incident analysis and forensic report structuring
- SOC detection gap analysis and investment prioritization
- Threat intelligence program design
- Security architecture review aligned with layered defense-in-depth
- Purple team exercises structured around phase-by-phase adversary progression
**Strengths and limitations:** The Kill Chain's linear, sequential model makes it intuitive and accessible to non-technical stakeholders including executives and board members. It clearly frames the value of early detection and demonstrates why intelligence-driven defense matters. However, the model's linearity is a significant limitation — modern adversaries frequently skip phases, operate nonlinearly, or repeat phases. The framework predates cloud, container, and supply chain attack vectors, reducing its fidelity for current threat landscapes. It is best used in combination with MITRE ATT&CK for operational specificity.
**Related frameworks:** MITRE ATT&CK, Diamond Model of Intrusion Analysis, NIST CSF, TARA, PASTA, STRIDE

---

### STRIDE Threat Modeling Framework
**Category:** Cybersecurity Risk
**Tags:** threat modeling, Microsoft, application security, secure design, SDLC
**How it works:** STRIDE is a threat categorization model developed by Microsoft in the late 1990s to systematically identify security threats during the design phase of software development ([CERT Destination](https://destcert.com/resources/threat-modeling-methodologies/)). The acronym represents six threat categories — Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege — each mapped to a specific security property violation (authentication, integrity, non-repudiation, confidentiality, availability, and authorization, respectively). Teams apply STRIDE by creating Data Flow Diagrams (DFDs) of the system being analyzed and systematically evaluating each component and data flow against all six threat categories. The output is a threat list that feeds directly into security control selection and architectural decisions. STRIDE can be combined with DREAD for severity scoring or with ATT&CK for technique-level specificity.
**Dimensions / components:**
- Spoofing (authentication violation — impersonating another user or system)
- Tampering (integrity violation — unauthorized modification of data)
- Repudiation (non-repudiation violation — denying having performed an action)
- Information Disclosure (confidentiality violation — exposing data to unauthorized parties)
- Denial of Service (availability violation — making systems unavailable)
- Elevation of Privilege (authorization violation — gaining unauthorized access levels)
**Guiding questions:**
- Has a complete Data Flow Diagram been created to identify all system components and trust boundaries?
- Which STRIDE categories apply to each component and data flow in the system?
- Are security controls identified and mapped to each applicable threat category?
- Have trust boundaries been explicitly identified and analyzed for crossing threats?
- Are STRIDE analysis results fed back into architecture and design decisions before implementation?
**Evaluation criteria:**
- Completeness of Data Flow Diagram coverage for all system components
- Thoroughness of STRIDE category application per component and data flow
- Quality and feasibility of mitigating controls identified per threat
- Integration of STRIDE outputs into security requirements and design documentation
- Time efficiency and repeatability of the STRIDE analysis process
**Typical use cases:**
- Secure software development lifecycle (SDLC) threat modeling during design phase
- API and web application security architecture reviews
- Cloud workload threat modeling during architecture design
- Security review of internal tools and microservices
- Developer security training through hands-on threat modeling exercises
**Strengths and limitations:** STRIDE's six-category taxonomy provides a structured, comprehensive lens for design-phase threat identification that prevents common security oversights. Its Microsoft origins and broad documentation make it one of the most accessible threat modeling frameworks for software teams. Integration with tools like Microsoft Threat Modeling Tool enables automation. Limitations include its assumption of complete Data Flow Diagrams, which are time-consuming to create accurately. The model's per-category approach can be mechanically applied without genuine threat reasoning, and it lacks built-in severity prioritization — requiring pairing with DREAD or CVSS.
**Related frameworks:** DREAD, PASTA, MITRE ATT&CK, LINDDUN (privacy), Kill Chain, Security Development Lifecycle (SDL)

---

### PASTA — Process for Attack Simulation and Threat Analysis
**Category:** Cybersecurity Risk
**Tags:** risk-centric, threat modeling, application security, business alignment, seven-stage
**How it works:** PASTA (Process for Attack Simulation and Threat Analysis) is a risk-centric, attacker-focused, seven-stage threat modeling methodology designed to align technical security analysis with business risk objectives ([Software Secured](https://www.softwaresecured.com/post/comparison-of-stride-dread-pasta)). Unlike STRIDE, which categorizes threat types, PASTA evaluates threats from the adversary's perspective and connects technical findings to business impact. The methodology incorporates input from governance, operations, architecture, and development teams, making it genuinely cross-functional. Each stage builds on the previous: from defining business objectives and technical scope through application decomposition, threat and vulnerability analysis, attack modeling, and final risk and impact analysis. PASTA's comprehensive, contextual outputs are well-suited to enterprise-level applications where aligning security decisions with business value is critical. PASTA's business-centric framing helps development organizations connect application-level security decisions to board-level risk appetite statements.
**Dimensions / components:**
- Stage 1: Define business objectives and application risk profile
- Stage 2: Define technical scope (technology stack, components, deployment model)
- Stage 3: Application decomposition and data flow analysis
- Stage 4: Threat analysis (threat intelligence, relevant threat actors)
- Stage 5: Vulnerability and weakness analysis (design and code review)
- Stage 6: Attack modeling and simulation (attack patterns and paths)
- Stage 7: Risk and impact analysis (risk quantification and mitigation prioritization)
**Guiding questions:**
- What are the business objectives the application supports, and what impact does a breach have on those objectives?
- Which threat actors are motivated to target this application, and what methods do they use?
- Do identified vulnerabilities align with and support the threat assertions from threat analysis?
- Which attack paths present the highest probability and impact combination?
- Are risk mitigation decisions prioritized based on business impact rather than technical severity alone?
**Evaluation criteria:**
- Alignment of Stage 1 business objectives with downstream risk analysis outputs
- Completeness of Stage 3 application decomposition and data flow coverage
- Quality and currency of threat intelligence feeding Stage 4 analysis
- Correlation between Stage 5 vulnerabilities and Stage 4 threat assertions
- Business-value alignment of Stage 7 risk prioritization decisions
**Typical use cases:**
- Enterprise-level application security threat modeling
- Security architecture reviews of complex, multi-tier systems
- Pre-launch risk assessments for major product or platform releases
- Compliance-driven security analysis requiring documented risk treatment decisions
- Security programs mature enough to sustain seven-stage analytical investment
**Strengths and limitations:** PASTA's business-risk alignment gives security teams outputs that resonate with non-technical stakeholders and directly support risk-based decision-making. Its attacker perspective produces more realistic threat assessments than category-based models. The seven-stage structure ensures comprehensive coverage from objectives to impact. However, PASTA's comprehensiveness comes at significant time and resource cost, making it impractical for small teams or rapid development cycles. Its effectiveness depends heavily on quality threat intelligence and analyst expertise, and it can produce analysis paralysis in organizations without mature risk decision-making processes.
**Related frameworks:** STRIDE, DREAD, MITRE ATT&CK, Kill Chain, ISO/IEC 27001, FAIR

---

### DREAD Threat Severity Rating Model
**Category:** Cybersecurity Risk
**Tags:** threat severity, risk scoring, prioritization, quantitative rating, cybersecurity
**How it works:** DREAD is a quantitative threat severity rating model used to rank and prioritize identified threats based on five dimensions — Damage potential, Reproducibility, Exploitability, Affected users, and Discoverability ([CERT Destination](https://destcert.com/resources/threat-modeling-methodologies/)). Each dimension is scored on a scale of 1 to 10, and the scores are averaged to produce an overall threat severity rating. DREAD is typically used in combination with threat identification frameworks like STRIDE — STRIDE identifies what threats exist, and DREAD ranks their severity to guide remediation priority. The model's numerical output enables comparison across threats and facilitates objective prioritization discussions between development and security teams. While DREAD has been partially displaced by CVSS in vulnerability management contexts, it remains useful for application-level threat prioritization where CVSS scores may not be available.
**Dimensions / components:**
- Damage potential (maximum impact if the threat is realized, 1–10)
- Reproducibility (ease of reliably reproducing the attack, 1–10)
- Exploitability (skill and resources required to exploit, 1–10)
- Affected users (proportion of user base impacted, 1–10)
- Discoverability (likelihood an attacker discovers the vulnerability, 1–10)
**Guiding questions:**
- What is the maximum business and technical damage if this threat is successfully exploited?
- How reliably can an attacker reproduce the exploit, and does it require specific conditions?
- What level of skill and tooling is required for an attacker to succeed?
- How many users or systems would be affected by a successful exploitation?
- How easily can the vulnerability be discovered by an attacker through reconnaissance?
**Evaluation criteria:**
- Calibration consistency of scores across analysts and threats
- Correlation of DREAD rankings with actual risk prioritization decisions
- Use of DREAD alongside complementary threat identification frameworks
- Periodic recalibration of scores as exploitability conditions change
- Transparency of scoring rationale for audit and review purposes
**Typical use cases:**
- Application security threat prioritization in SDLC processes
- Penetration testing findings prioritization and reporting
- Security backlog prioritization in agile development teams
- Combining with STRIDE for structured threat assessment workflows
- Security design review scoring for comparative analysis
**Strengths and limitations:** DREAD's numerical output creates a simple, comparable ranking system that is easy to explain to development teams and product managers. The five dimensions are intuitive and require no specialized tools. However, DREAD scores are highly subjective and prone to analyst bias, particularly for Discoverability, which is notoriously difficult to assess objectively. The model has been deprecated by Microsoft in favor of more nuanced approaches. When used without calibration or inter-rater consistency checks, DREAD can produce misleading priority rankings that misdirect remediation resources.
**Related frameworks:** STRIDE, CVSS, MITRE ATT&CK, PASTA, FAIR, CWE/OWASP Risk Rating Methodology

---

### CIS Controls Version 8
**Category:** Cybersecurity Risk
**Tags:** cybersecurity controls, implementation groups, prioritization, CIS, best practices
**How it works:** The Center for Internet Security (CIS) Controls Version 8 is a prioritized set of 18 security controls (reduced from 20 in v7) designed to provide specific, actionable defensive measures against the most prevalent cyber attacks. The controls are organized into three Implementation Groups (IGs) that reflect organizational maturity and resources: IG1 (essential cyber hygiene for all organizations), IG2 (additional controls for organizations with IT staff), and IG3 (advanced controls for organizations with dedicated security expertise). CIS Controls v8 was restructured around activities and outcomes rather than organizational functions, and for the first time explicitly addressed cloud and mobile environments. Each control includes specific Safeguards (formerly Sub-Controls) with defined asset types, security functions mapped to NIST CSF, and implementation guidance. Version 8, released in 2021, reorganized controls into 18 groups and mapped them explicitly to Implementation Groups, enabling proportionate adoption by organizations of different sizes and maturity.
**Dimensions / components:**
- Control 1–6: Basic cyber hygiene (asset inventory, software inventory, data protection, secure configuration, account management, access control management)
- Control 7–11: Foundational controls (vulnerability management, audit log management, email/browser security, malware defense, network monitoring)
- Control 12–18: Organizational controls (network infrastructure, security awareness, service provider management, application software security, incident response, penetration testing)
- Implementation Groups (IG1, IG2, IG3) for maturity-based prioritization
**Guiding questions:**
- Has the organization implemented all IG1 Safeguards as minimum essential cyber hygiene?
- Are asset inventories comprehensive enough to identify all assets requiring protection?
- Are access controls enforcing least-privilege principles across all critical systems?
- Is vulnerability management timely enough to address actively exploited vulnerabilities before adversaries reach them?
- Do audit logs provide sufficient coverage and retention to support incident investigations?
**Evaluation criteria:**
- Completeness of IG1 Safeguard implementation as baseline
- Coverage of IG2 and IG3 Safeguards proportionate to organizational risk profile
- Quality and completeness of hardware and software asset inventories
- Patch and vulnerability remediation timeliness against defined SLAs
- Security awareness program effectiveness measured through phishing simulation metrics
**Typical use cases:**
- Small and medium business cybersecurity program foundational design
- Healthcare, education, and local government cybersecurity baseline establishment
- Regulatory compliance gap analysis (HIPAA, PCI DSS, NIST CSF mapping)
- Vendor and third-party cybersecurity requirement specification
- Security program benchmarking against community average CIS Controls adoption
**Strengths and limitations:** CIS Controls' Implementation Group structure makes the framework uniquely accessible to organizations at any resource level, providing a clear prioritization path from basic hygiene to advanced controls. The mapping to NIST CSF, ISO 27001, and regulatory frameworks reduces redundant implementation work. The grounding in observed attack patterns ensures the controls address real threats. Limitations include the risk of treating IG completion as a compliance checklist rather than a risk-reduction exercise, and the controls' prescriptive nature can be inflexible for organizations with non-standard environments or legacy systems.
**Related frameworks:** NIST CSF, ISO/IEC 27001, NIST SP 800-53, PCI DSS, SOC 2, ATT&CK (coverage mapping)

---

### ISO/IEC 27005 Information Security Risk Management
**Category:** Cybersecurity Risk
**Tags:** ISO, risk assessment, information security, risk treatment, ISMS
**How it works:** ISO/IEC 27005 provides detailed guidance on information security risk management in support of ISO/IEC 27001. While ISO 27001 specifies what an organization must do for risk assessment and treatment, ISO 27005 explains how — providing a structured process covering risk identification, analysis (qualitative and quantitative), evaluation, treatment, acceptance, communication, and ongoing monitoring. The standard aligns with the general risk management principles of ISO 31000 while being specifically tailored to information security assets, threats, vulnerabilities, and impacts. The 2022 revision further aligned the standard with ISO 31000:2018 terminology and introduced a more flexible, scenario-based approach to risk assessment alongside the traditional asset-based approach. It serves as the technical companion for ISMS practitioners implementing ISO 27001. The 2022 revision added an event-based approach alongside the traditional asset-based methodology, providing greater flexibility for rapidly evolving digital environments.
**Dimensions / components:**
- Risk identification (assets, threats, vulnerabilities, existing controls, consequences)
- Risk analysis (likelihood assessment, consequence assessment, risk level determination)
- Risk evaluation (comparison against risk criteria, prioritization)
- Risk treatment (modification, retention, avoidance, sharing)
- Risk acceptance (formal residual risk acceptance by management)
- Risk communication and consultation
- Risk monitoring and review
**Guiding questions:**
- Are information assets comprehensively identified and valued by their owners?
- Are threats assessed in terms of their likelihood of exploiting identified vulnerabilities?
- Does risk analysis methodology (qualitative/quantitative) produce consistent, reproducible results?
- Are risk treatment options selected based on cost-benefit analysis relative to risk reduction achieved?
- Is residual risk formally accepted by accountable owners with appropriate authority?
**Evaluation criteria:**
- Completeness of asset, threat, and vulnerability identification
- Consistency and reproducibility of risk level determination methodology
- Adequacy of risk treatment options considered for high-priority risks
- Formality and documentation of residual risk acceptance decisions
- Integration of risk monitoring outputs into ISMS management review
**Typical use cases:**
- Implementing the risk assessment requirements of ISO/IEC 27001
- Selecting a risk assessment methodology for an ISMS program
- Maturing from ad-hoc to structured information security risk assessment
- Aligning information security risk with enterprise risk management programs
- Supporting ISO 27001 certification audit preparation
**Strengths and limitations:** ISO 27005's detailed process guidance fills the implementation gap left by ISO 27001's high-level requirements, making it an indispensable companion for ISMS practitioners. The 2022 revision's alignment with ISO 31000 improves integration with enterprise risk management. The standard's flexibility in accepting both qualitative and quantitative risk analysis methods accommodates organizations at different maturity levels. Limitations include the standard's lack of prescriptive tools, meaning organizations must still select or develop their own risk assessment templates and scoring methods, which can lead to inconsistency across departments.
**Related frameworks:** ISO/IEC 27001, ISO 31000, NIST SP 800-30, OCTAVE, FAIR, ISO/IEC 27002

---

### NIST AI Risk Management Framework (AI RMF 1.0)
**Category:** Cybersecurity Risk
**Tags:** artificial intelligence, AI risk, trustworthiness, NIST, AI governance
**How it works:** The NIST AI Risk Management Framework, published in January 2023, is a voluntary framework designed to help organizations manage risks associated with artificial intelligence systems and incorporate trustworthiness throughout the AI lifecycle ([NAVEX](https://www.navex.com/en-us/blog/article/risk-management-frameworks-for-organizations/)). The AI RMF is structured around four core functions — Govern, Map, Measure, and Manage — that collectively establish AI risk governance, contextualize AI risks, analyze and measure them, and prioritize and address them. An accompanying AI RMF Playbook provides detailed actions and outcomes for each function. A 2024 companion document, NIST-AI-600-1, addresses 12 categories of risk unique to Generative AI systems. The framework emphasizes trustworthiness properties including accuracy, explainability, fairness, privacy, reliability, safety, security, and transparency, and is designed to complement existing risk management programs. The framework's voluntary nature allows organizations to adopt AI governance at a pace proportionate to their AI deployment maturity and risk exposure.
**Dimensions / components:**
- Govern: culture, accountability, risk tolerances, policies, workforce diversity
- Map: AI context, risk identification, AI actor roles and responsibilities
- Measure: AI risk analysis, monitoring, measurement methodology
- Manage: risk treatment, response and recovery planning, residual risk tracking
- Trustworthiness properties (accuracy, explainability, fairness, interpretability, privacy, reliability, safety, security, transparency)
- AI RMF Playbook (suggested actions per function)
**Guiding questions:**
- Has the organization established AI risk governance policies, roles, and risk tolerances?
- Are AI-specific risks mapped across the AI lifecycle including deployment and monitoring?
- Are trustworthiness properties measured for deployed AI systems using appropriate metrics?
- Are AI incident response and recovery plans documented and tested?
- How are human oversight mechanisms designed to catch and correct AI errors or biases?
**Evaluation criteria:**
- Presence and quality of AI-specific risk governance policies and accountability structures
- Completeness of risk mapping across AI development, deployment, and operations
- Availability of metrics for each trustworthiness property for deployed systems
- Rigor and independence of AI risk measurement activities
- Effectiveness of AI risk treatment and incident response programs
**Typical use cases:**
- Enterprise AI governance program design
- AI procurement and vendor risk management
- GenAI deployment risk assessment using NIST-AI-600-1
- Regulatory compliance preparation for EU AI Act, NIST alignment requirements
- Board-level AI risk reporting and oversight program design
**Strengths and limitations:** The AI RMF's comprehensive trustworthiness property framework addresses a wider range of AI risks than purely technical security frameworks. Its government publication provides credibility and a policy anchor for corporate AI governance. The Playbook's specific suggested actions reduce implementation ambiguity. However, as AI regulation evolves rapidly, the framework's voluntary nature and 2023 publication date may make it lag behind regulatory requirements (notably the EU AI Act). Measurement methodology for trustworthiness properties remains immature in practice, and the framework's breadth can overwhelm organizations new to AI risk management.
**Related frameworks:** ISO/IEC 42001, EU AI Act, NIST CSF, ISO 31000, COSO ERM, Responsible AI frameworks

---

### COBIT 2019 (Control Objectives for Information and Related Technology)
**Category:** Governance
**Tags:** IT governance, ISACA, enterprise IT, control objectives, audit, assurance
**How it works:** COBIT 2019, published by ISACA, is a comprehensive governance and management framework for enterprise information and technology ([Splunk](https://www.splunk.com/en_us/blog/learn/risk-management-frameworks.html)). Originally developed for financial auditors, COBIT bridges the gap between technical IT issues, business risks, and control requirements. COBIT 2019 introduced a design and implementation guide, a performance management system, and a more flexible structure than its predecessors, enabling organizations to design a governance system tailored to their specific enterprise goals, risk profile, IT-related issues, and threat landscape. The framework organizes 40 governance and management objectives across five domains (Evaluate, Direct, Monitor for governance; Align, Plan, Organize; Build, Acquire, Implement; Deliver, Service, Support; Monitor, Evaluate, Assess for management), each with design factors influencing the prioritization and tailoring of objectives. COBIT 2019 introduced a flexible design factor model allowing organizations to calibrate governance objectives to their specific enterprise context and strategy.
**Dimensions / components:**
- Governance domain: EDM (Evaluate, Direct, Monitor)
- Management domain: APO (Align, Plan, Organise)
- Management domain: BAI (Build, Acquire, Implement)
- Management domain: DSS (Deliver, Service, Support)
- Management domain: MEA (Monitor, Evaluate, Assess)
- Design factors (enterprise strategy, risk profile, IT-related issues, compliance requirements)
- Performance management (maturity/capability levels per objective)
**Guiding questions:**
- Are IT governance decisions made by appropriate governing bodies with defined authority?
- Is the IT investment portfolio aligned with enterprise strategy and value delivery expectations?
- Are IT-related risks identified, assessed, and reported to business leadership?
- Do IT processes achieve the capability levels needed to meet enterprise goals?
- Are IT controls independently monitored and assessed through the MEA domain?
**Evaluation criteria:**
- Alignment of COBIT governance objectives with enterprise-level goals
- Appropriateness of governance system design relative to design factors
- Capability level achievement across priority governance and management objectives
- Quality of IT performance measurement and reporting to governing bodies
- Independence and rigor of MEA domain monitoring and assessment activities
**Typical use cases:**
- IT governance program design and maturity assessment
- IT audit planning and execution using COBIT objectives as assessment criteria
- Regulatory compliance for DORA, SOX IT controls, and GDPR governance requirements
- IT governance benchmarking and gap analysis
- Board and executive IT governance reporting program design
**Strengths and limitations:** COBIT 2019's design-factor approach enables genuine tailoring rather than forcing all organizations to implement the same control set, improving relevance and efficiency. Its comprehensive scope covering both governance and management ensures alignment from the board level to operational IT processes. The performance management system enables maturity progression tracking. Limitations include significant implementation complexity and learning curve, making it resource-intensive to implement in full. Organizations sometimes implement COBIT as a documentation exercise rather than a genuine governance transformation, limiting its practical impact.
**Related frameworks:** ISO/IEC 27001, NIST CSF, COSO ERM, COSO Internal Control, IT4IT, ITIL

---

### SOX — Sarbanes-Oxley Act Internal Control Framework
**Category:** Governance
**Tags:** financial reporting, SEC, public company, internal control, PCAOB, Section 404
**How it works:** The Sarbanes-Oxley Act of 2002 (SOX) established sweeping corporate governance and financial reporting requirements for publicly listed companies in the United States following major accounting scandals. Section 302 requires CEO and CFO quarterly certification of disclosure controls and procedures. Section 404 mandates annual management assessment and auditor attestation of internal control over financial reporting (ICFR), typically using the COSO Internal Control — Integrated Framework as the assessment criteria. SOX compliance drives significant investment in process documentation, IT general controls (ITGCs), control testing, and remediation programs. The PCAOB issues auditing standards governing the auditor's attestation on ICFR. SOX's requirements have materially increased financial reporting reliability and auditor independence, though compliance costs remain substantial particularly for smaller public companies. SOX transformed U.S. corporate governance by making senior executives personally accountable for the accuracy of financial statements through Section 302 CEO and CFO certifications.
**Dimensions / components:**
- Section 302: CEO/CFO disclosure controls certification
- Section 404(a): Management's annual ICFR assessment
- Section 404(b): Auditor attestation on ICFR (accelerated filers and above)
- IT General Controls (ITGCs): access management, change management, operations
- Entity-level controls (ELCs) and process-level controls
- Disclosure committee and internal control over disclosure
- Audit committee independence requirements (Section 301)
**Guiding questions:**
- Are all material financial reporting processes documented with adequate control coverage?
- Are IT general controls (access, change, operations) operating effectively for financially significant systems?
- Has management identified all significant accounts and disclosures requiring ICFR coverage?
- Are control deficiencies remediated timely and classified accurately (deficiency, significant deficiency, material weakness)?
- Does the audit committee have financial expertise and independence to fulfill its oversight role?
**Evaluation criteria:**
- Completeness of ICFR scope covering all significant accounts and processes
- Operating effectiveness of controls as evidenced by testing results
- Timeliness and adequacy of deficiency identification and remediation
- Quality of management's ICFR assessment documentation
- Auditor concurrence with management's ICFR assessment conclusion
**Typical use cases:**
- SOX 404 compliance programs for accelerated filers and large accelerated filers
- IT general controls design and testing programs
- IPO readiness preparation requiring SOX control infrastructure
- Post-restatement remediation programs
- Acquisition integration requiring SOX control extension to acquired entities
**Strengths and limitations:** SOX Section 404 has materially improved the reliability of financial reporting for public companies and created a rigorous internal control ecosystem. The mandatory auditor attestation requirement provides independent verification that management assessments lack. However, SOX compliance costs are substantial, particularly for smaller companies and recent IPOs, and there is ongoing debate about whether compliance activities deliver proportionate value beyond regulatory adherence. The framework's financial reporting focus means it does not address operational or strategic risks absent from financial statements.
**Related frameworks:** COSO Internal Control, PCAOB AS 2201, SEC Disclosure Rules, COBIT 2019, NIST SP 800-53 (for ITGCs), CAQ Guidance

---

### GRC Framework — Governance, Risk, and Compliance Integration
**Category:** Governance
**Tags:** GRC, integrated management, governance, risk, compliance, enterprise-wide
**How it works:** The GRC Framework integrates governance structures, risk management strategies, and compliance processes into a unified organizational discipline rather than managing them as isolated functions ([MetricStream](https://www.metricstream.com/whitepapers/GRC-framework.htm)). The Open Compliance and Ethics Group (OCEG) developed the foundational GRC Capability Model (also known as the "Red Book") that defines the core components of an integrated GRC program. GRC integration eliminates redundant assurance activities, reduces silos between risk, compliance, legal, and audit functions, and provides boards and executives with a consolidated view of the organization's risk and compliance posture. Technology platforms support GRC integration by centralizing risk registers, policy libraries, control testing, compliance calendars, and regulatory change tracking. Effective GRC programs align risk appetite, compliance obligations, and governance accountability into a coherent operating model.
**Dimensions / components:**
- Governance (board oversight, accountability, culture, objectives)
- Risk management (risk identification, assessment, treatment, monitoring)
- Compliance (regulatory obligation inventory, compliance testing, reporting)
- Assurance integration (coordinating internal audit, risk, and compliance activities)
- Policy management (policy library, communication, exceptions, enforcement)
- Technology and data (GRC platforms, risk data aggregation, reporting dashboards)
**Guiding questions:**
- Are governance, risk, and compliance activities coordinated to eliminate gaps and redundancy?
- Does the organization have a consolidated view of all regulatory obligations and their compliance status?
- Are risk and compliance data aggregated to support board-level integrated reporting?
- Is policy management centralized and linked to control testing and compliance monitoring?
- Do GRC activities support organizational strategy and value creation rather than merely fulfilling compliance requirements?
**Evaluation criteria:**
- Degree of integration between governance, risk, and compliance functions
- Quality and completeness of the regulatory obligation inventory
- Efficiency gains from assurance coordination (reduced duplication)
- Quality of integrated risk and compliance reporting to governing bodies
- Maturity of GRC technology enablement
**Typical use cases:**
- Enterprise GRC program design and technology platform selection
- Regulatory change management in heavily regulated industries
- Post-merger integration of risk and compliance programs
- Board-level integrated risk and compliance reporting program design
- Audit committee support through consolidated GRC reporting
**Strengths and limitations:** GRC integration eliminates costly redundancies in assurance and compliance activities, producing efficiency gains and a clearer organizational risk picture. A single GRC technology platform reduces data fragmentation and enables real-time risk and compliance dashboards. Executive and board visibility of integrated risk and compliance posture is significantly enhanced. Limitations include the significant investment required in technology, process redesign, and cultural change to achieve genuine integration. Organizations often implement GRC technology without the underlying process and governance changes needed to realize integration benefits, resulting in expensive but underutilized platforms.
**Related frameworks:** COSO ERM, COSO Internal Control, ISO 31000, Three Lines Model, OCEG Red Book, COBIT 2019

---

### G20/OECD Principles of Corporate Governance
**Category:** Governance
**Tags:** corporate governance, OECD, board oversight, shareholder rights, global standard
**How it works:** The G20/OECD Principles of Corporate Governance, most recently updated in 2023, represent the international reference standard for corporate governance policy and regulation. Developed by the OECD, they address rights and equitable treatment of shareholders, institutional investors' responsibilities, transparency and disclosure, the role of stakeholders, and board responsibilities. The Principles are designed to inform national legislation and regulatory frameworks rather than serving as a directly implementable corporate governance code. They have influenced governance codes worldwide including the UK Corporate Governance Code, King IV, and listed company regulations in emerging markets. The 2023 revision strengthened guidance on sustainability, board diversity, and the governance of cybersecurity and climate risk. The principles were substantially revised in 2023 to address sustainability disclosures, digital governance, and the growing role of institutional investors.
**Dimensions / components:**
- Ensuring the basis for an effective corporate governance framework
- Rights and equitable treatment of shareholders
- Institutional investors, stock markets, and other intermediaries
- The role of stakeholders in corporate governance
- Disclosure and transparency
- Board responsibilities (structure, independence, accountability, risk oversight)
**Guiding questions:**
- Does the board composition provide the mix of skills, independence, and diversity needed for effective oversight?
- Are minority shareholder rights protected in the governance framework?
- Is material financial and non-financial information disclosed with sufficient accuracy and timeliness?
- Do institutional investors exercise their ownership responsibilities in an engaged and informed manner?
- Is the board's risk oversight function equipped to address emerging risks including cyber and sustainability?
**Evaluation criteria:**
- Alignment of national or corporate governance codes with OECD Principles
- Board independence levels and committee structure adequacy
- Quality and comparability of disclosure against international standards
- Effectiveness of shareholder engagement and dispute resolution mechanisms
- Board evaluation processes and succession planning practices
**Typical use cases:**
- National corporate governance code development and benchmarking
- Board governance review and board effectiveness evaluation
- Investor stewardship framework development
- Regulatory examination of listed company governance practices
- International governance benchmarking for cross-border investments
**Strengths and limitations:** The OECD Principles' intergovernmental endorsement gives them unique policy authority in shaping national governance frameworks globally. The 2023 revision's coverage of sustainability and cyber risk reflects contemporary governance challenges. Their adaptability across diverse legal and ownership structures makes them broadly applicable. Limitations include their high-level, principles-based nature that provides little operational guidance for specific governance decisions. Their effectiveness depends entirely on the quality of national implementation, which varies significantly across jurisdictions.
**Related frameworks:** King IV, UK Corporate Governance Code, COSO ERM, IIRC Integrated Reporting, TCFD, EU Corporate Sustainability Reporting Directive (CSRD)

---

### Enterprise Risk Appetite Framework
**Category:** Governance
**Tags:** risk appetite, risk tolerance, governance, strategy, board-level
**How it works:** The Enterprise Risk Appetite Framework provides a structured methodology for defining, articulating, communicating, and monitoring the amount and type of risk an organization is willing to accept in pursuit of its objectives. Risk appetite sits at the intersection of strategy and risk management — it must be set before strategic decisions can be evaluated against an acceptable risk range. The framework typically comprises a risk appetite statement (qualitative organizational stance), risk appetite metrics and thresholds (quantitative limits per risk category), risk tolerance bands (acceptable performance ranges around appetite), and risk limits (hard operational limits triggering escalation). A well-designed risk appetite framework cascades from the board through senior management to business unit level, ensuring strategic risk-taking is consciously bounded and monitored. IIF, FSB, and COSO ERM all provide guidance on risk appetite framework components.
**Dimensions / components:**
- Risk appetite statement (qualitative organizational risk stance)
- Risk appetite by risk category (credit, market, operational, reputational, strategic)
- Risk appetite metrics and quantitative thresholds
- Risk tolerance bands (range around appetite)
- Risk limits and limit escalation protocols
- Cascading to business unit and process level
- Governance linkage (board approval, periodic review, management reporting)
**Guiding questions:**
- Has the board explicitly approved a risk appetite statement aligned with organizational strategy?
- Are quantitative risk appetite metrics available and monitored for each material risk category?
- Do risk tolerance bands reflect genuine business judgment about acceptable variation?
- Are risk limits calibrated to trigger timely management escalation before appetite is breached?
- Is the risk appetite framework reviewed and updated when strategy changes materially?
**Evaluation criteria:**
- Clarity and specificity of the risk appetite statement
- Availability and reliability of metrics measuring risk against appetite
- Frequency and quality of risk appetite reporting to the board
- Evidence that strategic decisions reference the risk appetite framework
- Responsiveness of limit escalation processes when thresholds are approached or breached
**Typical use cases:**
- Board-level risk governance program development
- Annual strategic planning cycle integration with risk appetite setting
- Regulatory compliance for banking, insurance, and asset management risk appetite requirements
- Mergers and acquisitions risk assessment relative to combined entity appetite
- Post-incident calibration of risk appetite limits
**Strengths and limitations:** A well-designed risk appetite framework converts abstract risk governance concepts into concrete, measurable governance boundaries that boards and management can act on. It prevents both excessive risk-aversion and reckless risk-taking by making acceptable risk ranges explicit. Regulatory expectations in financial services make risk appetite frameworks essential for compliance. Limitations include the tendency toward overly generic appetite statements that provide little operational guidance, and the difficulty of quantifying appetite for non-financial risks (reputational, strategic). Risk appetite frameworks can also become stale between annual reviews, making real-time monitoring challenging.
**Related frameworks:** COSO ERM, ISO 31000, FSB Principles for Sound Risk Appetite Frameworks, Three Lines Model, King IV, Basel III

---

### PCI DSS — Payment Card Industry Data Security Standard
**Category:** Compliance
**Tags:** payment card, data security, cardholder data, compliance, financial services, retail
**How it works:** PCI DSS, mandated by the Payment Card Industry Security Standards Council (founded by Visa, Mastercard, American Express, Discover, and JCB), is a compliance framework for any organization that stores, processes, or transmits cardholder data. Version 4.0, published in 2022, reorganized requirements around defined goals, added a customized implementation approach for mature security programs, and strengthened authentication requirements. The standard comprises 12 requirements covering network security, cardholder data protection, vulnerability management, access control, monitoring, and information security policy. Compliance is validated through Qualified Security Assessor (QSA) assessments for large merchants, or Self-Assessment Questionnaires (SAQs) for smaller merchants. Non-compliance can result in card scheme fines, increased transaction costs, and loss of card processing privileges. Version 4.0, published in 2022, introduced customized implementation options allowing organizations to demonstrate alternative controls that achieve equivalent security outcomes.
**Dimensions / components:**
- Req 1–2: Network security (firewalls, system configuration standards)
- Req 3–4: Cardholder data protection (data storage limits, encryption in transit)
- Req 5–6: Vulnerability management (malware protection, secure development)
- Req 7–8: Access control (least privilege, authentication, MFA)
- Req 9: Physical access controls for cardholder data environments
- Req 10–11: Logging, monitoring, and security testing
- Req 12: Information security policy and program
**Guiding questions:**
- Has the cardholder data environment (CDE) scope been accurately and minimally defined?
- Are all cardholder data storage locations inventoried and subject to data retention controls?
- Are authentication controls meeting PCI DSS 4.0's strengthened MFA and password requirements?
- Does the organization have vulnerability scanning and penetration testing meeting PCI DSS frequency requirements?
- Are logging and monitoring controls providing the coverage required by Requirement 10?
**Evaluation criteria:**
- Accuracy and minimization of CDE scope definition
- Effectiveness of network segmentation protecting the CDE
- Operating effectiveness of the 12 requirements' controls during QSA assessment
- Timeliness of vulnerability and penetration test remediation
- Quality and completeness of information security policies and procedures
**Typical use cases:**
- Retail, e-commerce, and hospitality cardholder data security programs
- Payment processor and service provider PCI DSS certification
- Merchant bank card acceptance program compliance management
- Cloud service provider PCI DSS compliance for payment workloads
- Post-breach cardholder data environment remediation
**Strengths and limitations:** PCI DSS provides specific, prescriptive requirements that leave less ambiguity than principles-based frameworks, making compliance testing more straightforward. Card scheme enforcement creates strong commercial incentives for compliance. The customized implementation approach in v4.0 enables mature organizations to demonstrate equivalent security through alternative controls. Limitations include scope creep risk when CDE boundaries are imprecisely defined, the compliance point-in-time nature that may not reflect ongoing security posture, and the prescriptive requirements that can drive compliance-focused implementations without genuine security outcomes.
**Related frameworks:** NIST CSF, ISO/IEC 27001, SOC 2, CIS Controls, NIST SP 800-53, GDPR

---
