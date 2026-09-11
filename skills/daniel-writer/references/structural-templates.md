# Structural Templates — Post Types

Detailed templates for each post type Daniel writes. The SKILL.md contains the principles; this file contains the full patterns with examples.

## Technical Explanation Posts

Include ALL of these elements:

### 1. "The Vision" Section
One aspirational paragraph showing the end benefit for the community. Keep it concrete — what does the world look like when this works?

### 2. Numbered Flow Breakdown

```markdown
### 1 – Who publishes events and where?

| Role | Tool | Example |
|------|------|---------|
| Organizer | WordPress | TangoClub Berlin posts on their site |
| Professional | Mobilizon | Teacher María uses event platform |

### 2 – Where does the data gather?
[Aggregation layer explanation]

### 3 – How dancers interact
1. Dancers follow their favorite organizers
2. Events appear in chronological timeline
3. No algorithm decides what's "engaging enough"
```

### 3. Comparison Table
3–5 columns. Real tool names. Include concrete examples in the final column.

### 4. Concrete Walk-Through with Named Persona

```markdown
### A concrete walk-through

María creates a "Saturday Practica" post on her WordPress site...
- She fills in: date, time, location, price
- The ActivityPub plugin automatically broadcasts it
- Within seconds, her 200 followers see it in their Mastodon timeline
- No ads interrupt the message
```

### 5. ASCII Flow Diagram

```
Publisher → ActivityPub → Aggregator → Dancer's Feed
```

---

## Community Persuasion Posts

Follow this trust-building arc:

### Step 1: Show You Understand Current Behavior (Empathy)
> "The tango network has been using Facebook for more than a decade..."

### Step 2: Acknowledge Valid Reasons (Validation)
> "### Why Dancers Use Facebook"
List the real reasons people stay. No straw-manning.

### Step 3: Introduce Alternative View (Gentle Pivot)
> "Or so many think."

### Step 4: Present Evidence (Data Without Confrontation)
Comparison tables, specific examples, contextualized statistics.

### Step 5: Honest Trade-Offs (Transparency)

```markdown
## What we will need to understand

A non-Facebook place will not be like Facebook. It may look similar, but it won't be that.

**What We Will Lose:**
- [Honest acknowledgment 1]
- [Honest acknowledgment 2]

**What We Will Gain:**
- [Benefit 1]
- [Benefit 2]
```

State losses BEFORE gains. No sugarcoating. Use "we" throughout.

---

## Strategic/Visionary Posts

### Opening: Direct Value + Honest Obstacle

```markdown
## Here's an idea for...

[Direct value proposition — one paragraph]

The biggest challenge here is [honest obstacle acknowledgment].
```

### Middle: Systematic Breakdown

```markdown
## How it could work

[Numbered workflow OR comparison table]
```

### FAQ-Style Concern Addressing

```markdown
## What about [common concern]?

[Honest answer acknowledging limitations]
```

### Closing: Incremental Starting Point

```markdown
## What would be a first starting point?

1. Let's start with [specific tool/action]. Ideally this is [preference, not requirement].
2. We'll try to [tentative second step]...
3. After [timeframe], we evaluate what worked and what didn't.
```

---

## Data-Driven Analysis Posts

### The Evidence Sandwich Pattern (Repeat Throughout)

```
[Emotional hook — what the reader is feeling]
↓
[Hard data — specific numbers with sources]
↓
[Contextual interpretation — what this means for YOU personally]
```

Example from Article 1:

> You organize a fantastic milonga, post it on Facebook... and barely anyone shows up.
>
> Facebook's average organic reach sits at **2.6%** (Hootsuite, 2025). That means if you have 500 followers, maybe 13-25 people see your event announcement.
>
> You're not failing at promotion — **the platform is working exactly as designed**.

### Data Presentation Rules

1. **Always contextualize** — translate percentages into the reader's reality
2. **Source inline** — "(Hootsuite, 2025)" not footnotes
3. **One key number per point** — too many = cognitive overload
4. **Show the trend** — historical data points showing direction (2012: 16% → 2018: 6% → 2025: 2.6%)
5. **Use ironic juxtaposition** — platform's own words vs. reality

### Section Structure

```markdown
## The Numbers Don't Lie

Here's what's actually happening, backed by [year] data:

**[Topic]: [Trend Name]**
- **[Year]**: [data point]
- **[Year]**: [data point with context]
- **[Year]**: [current data with personal impact translation]

**Why This Is Happening (According to [Source]'s Own Numbers)**
[Business model explanation that reveals the mechanism]

**What This Means for [Reader's Context]**
[Personal impact statement connecting data to reader's experience]
```

---

## Series Architecture

When writing a multi-part series, follow the progressive trust-building arc:

| Article | Trust Layer | Emotional Arc | Structure |
|---------|------------|---------------|-----------|
| 1 | Validation | "You're not imagining it" | Pain → Evidence → Survey CTA |
| 2 | Evidence | "Here's proof it's systemic" | Data → Patterns → Implications |
| 3 | Mechanism | "Here's the system behind it" | History → Economics → Technical |
| 4 | Agency | "Here's what we can do" | Vision → Architecture → Action |

Each article should stand alone but gain depth from the series context.

### Cross-Article Linking Pattern

```markdown
---

*This article is part of the [Series Name] exploring [topic].*

**Previous**: [Previous Article Title](previous-article.md)
**Next**: [Next Article Title](next-article.md)
```

---

## Opening Sentence Patterns (From Actual Posts)

These are the specific sentence shapes Daniel uses to open:

**Direct experience drop-in:**
> "You organize a fantastic milonga, post it on Facebook, share it in groups, invite your friends... and barely anyone shows up."

**Nostalgic anchor:**
> "Remember when Facebook actually worked for communities?"

**Pattern observation:**
> "From Berlin to Buenos Aires, from London to Los Angeles, tango communities report the same frustrations:"

**Definition reframe:**
> "**Digital sovereignty** isn't just a technical concept — it's about community self-determination in the digital age."

**Analogy bridge:**
> "Think of TangoVerse federation like email: different providers can all communicate."

---

## Closing Sentence Patterns

**Collaborative invitation:**
> "Let's build something better — together."

**Agency statement:**
> "The future of tango community digital infrastructure is in our hands."

**Bridge to next:**
> "Understanding the problem is the first step."

**Honest uncertainty with optimism:**
> "We don't know if this will work. But we know the current path leads somewhere worse."
