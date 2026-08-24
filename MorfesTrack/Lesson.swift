import Foundation

struct Lesson: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let estimatedMinutes: Int
    let xpReward: Int
    let content: [LessonSection]
    let tags: [String]
}

struct LessonSection: Identifiable {
    let id = UUID()
    let type: SectionType
    let text: String

    enum SectionType {
        case hook, concept, example, keyInsight, summary, socratiсPrompt
    }
}

enum CompetitiveLessonLibrary {

    static let allLessons: [Lesson] = [lesson01, lesson02, lesson03, lesson04,
                                        lesson05, lesson06, lesson07, lesson08,
                                        lesson09, lesson10, lesson11, lesson12]

    // MARK: — Lesson 01

    static let lesson01 = Lesson(
        id: "L01",
        title: "Reading Water Like a Judge",
        subtitle: "The foundation of every championship tank begins not with plants — but with water chemistry.",
        estimatedMinutes: 12,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: """
The 2019 IAPLC Grand Prize winner spent six months designing the composition. The plants were perfect. The stones were arranged with mathematical precision. Then, one week before the photography deadline, the water turned milky with a bacterial bloom.

He lost two weeks of irreplaceable growth time. He finished 4th.

The aquascape that wins a world championship is not the most beautiful one on paper — it's the one where the aquascaper understood water well enough to avoid disasters at the worst moments. That understanding begins here.
"""),
            LessonSection(type: .concept, text: """
**Concept 1: The pH-CO₂-KH Triangle**

These three parameters are mathematically linked. Increase one and the others shift. Competition aquascapers must understand this triangle intuitively, not just theoretically.

KH (carbonate hardness) acts as a pH buffer — the more KH in your water, the more resistant pH is to change. CO₂ dissolves into carbonic acid, which consumes KH buffering capacity and lowers pH.

The relationship follows a fixed formula: at a given KH value, the amount of CO₂ dissolved in water directly determines pH. At KH=4 dKH, a pH of 6.6 means approximately 44 mg/L CO₂ — dangerously high for fish but excellent for plant growth. At pH 7.0 with the same KH, CO₂ drops to around 15 mg/L — barely adequate for demanding plants.

This is why competition tanks run low KH (2–4 dKH) and slightly acidic water (pH 6.2–6.8): it allows stable, adequate CO₂ saturation without requiring extreme injection rates.

**Practical implication**: If you see your drop checker turning blue (CO₂ low) while injection appears to be running correctly, check KH first. High KH is a CO₂ thief.
"""),
            LessonSection(type: .concept, text: """
**Concept 2: GH and the Mineral Vocabulary of Plants**

General Hardness (GH) measures dissolved calcium (Ca²⁺) and magnesium (Mg²⁺) ions. These aren't just "hardness" — they are structural materials plants use daily.

Calcium: essential for cell wall synthesis, signal transduction, and tip growth of roots and new shoots. Deficiency shows as distorted new growth — twisted, cupped, or stunted leaves. In fast-growing stems like Rotala rotundifolia, calcium deficiency appears within 4–6 days of depletion.

Magnesium: the atom at the center of every chlorophyll molecule. Without Mg, no photosynthesis occurs. Deficiency classically shows as interveinal chlorosis — yellow between leaf veins while veins remain green. Many aquascapers confuse this with iron deficiency; the key difference is that magnesium deficiency starts on older leaves (plant relocates it forward to new growth) while iron deficiency starts on new leaves.

Target range for competition tanks: GH 4–8 dGH. Soft water (GH < 3) with South American or Southeast Asian plants requires Equilibrium or GH booster supplementation.
"""),
            LessonSection(type: .concept, text: """
**Concept 3: TDS as a Holistic Proxy**

Total Dissolved Solids (TDS), measured in parts per million (ppm) with a conductivity meter, doesn't tell you what's in your water — but it tells you how much is in there. For competition aquascapers, TDS serves as a quick daily sanity check.

A well-maintained planted competition tank typically runs 100–200 ppm TDS. After a water change with remineralized RO water, TDS should return to baseline within ±10 ppm. If TDS climbs 20–30 ppm above baseline between water changes, investigate: excess fertilizer dosing, organic matter buildup, or substrate leaching.

During the new tank period (first 8 weeks), TDS often rises as the substrate releases compounds. This is expected — but if it rises above 300 ppm, increase water change frequency.

Critical insight: never use tap water TDS as your target. Tap water may have 300+ ppm, but that TDS is composed of chloramines, heavy metals, and phosphates — not the clean mineral profile plants need. Always use RO water remineralized to specification.
"""),
            LessonSection(type: .keyInsight, text: """
**Key Insight — The Competition Water Formula**

Winning tanks share nearly identical water parameters:
- pH: 6.4 – 6.8
- KH: 2 – 4 dKH  
- GH: 4 – 8 dGH
- NO₃: 5 – 20 ppm
- PO₄: 0.5 – 2 ppm
- TDS: 100 – 200 ppm
- CO₂: 25 – 35 mg/L (drop checker: yellow-green)

These are not rules — they are the distilled parameters of 30 years of competitive aquascaping data. Deviate with reason, not ignorance.
"""),
            LessonSection(type: .example, text: """
**Real-World Application: Diagnosing the Dying Competition Tank**

A planted 90cm competition tank running ADA substrate, CO₂ injection, and EI fertilization suddenly shows yellowing on Rotala H'ra tips (new growth) after week 6.

Diagnosis process:
1. Check pH and compare to baseline → pH 7.2 (was 6.6) → CO₂ system check needed
2. Check drop checker → green (low CO₂)
3. Check CO₂ diffuser → visible clog from calcium buildup
4. Clean diffuser with citric acid solution, recheck CO₂ → drop checker yellow-green within 2 hours
5. New leaf damage: likely caused by 3-day CO₂ deficiency causing temporary iron/calcium lockout at elevated pH

Fix: 50% water change to dilute any waste buildup, resume normal CO₂, expect recovery in 7–10 days.

The lesson: water chemistry problems masquerade as nutrient problems 70% of the time. Fix water parameters first, fertilization second.
"""),
            LessonSection(type: .summary, text: """
**Summary: Water is the Medium and the Message**

Competition aquascaping wins and loses in the water column before a single plant is placed. Master the pH-CO₂-KH triangle. Know what GH deficiencies look like on leaves. Use TDS as your daily vital sign.

The plants you choose, the composition you design, the stones you source — all of it is irrelevant if the water chemistry is fighting you. The aquascapers who win consistently are not necessarily the most creative. They're the ones who have so thoroughly mastered water chemistry that it never surprises them.

In the next lesson, we'll build on this foundation by exploring how CO₂ injection systems work mechanically — and why equipment choice separates champion tanks from almost-champion tanks.
"""),
        ], tags: ["beginner", "water chemistry", "fundamentals"]
    )

    // MARK: — Lesson 02

    static let lesson02 = Lesson(
        id: "L02",
        title: "The Mechanics of CO₂ — Precision Injection for Competition",
        subtitle: "CO₂ is the most powerful growth lever in planted competition tanks. Used imprecisely, it's also the fastest way to kill everything.",
        estimatedMinutes: 14,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: """
In 2015, a European aquascaper in the IAPLC top 50 posted a photograph that confused every beginner who saw it: his tank, three days before the photography deadline, was completely covered in green dust algae. The plants were buried. He appeared finished.

He did a 90% water change, cleaned every surface, and submitted the tank photo 72 hours later. It placed 31st globally.

The weapon he used to recover? Perfectly calibrated CO₂, injected at exactly the right timing, at exactly the right saturation level. Understanding CO₂ mechanics at this precision level is what separates reactive aquascapers from proactive ones.
"""),
            LessonSection(type: .concept, text: """
**Concept 1: Pressure, Regulators, and the Stability Imperative**

CO₂ travels from a pressurized cylinder (typical competition: 2kg or 5kg aluminum) through a dual-stage regulator. Understanding regulator anatomy prevents the most common competition failure: end-of-tank dump.

A single-stage regulator outputs variable pressure as cylinder pressure drops. When a cylinder nears empty, single-stage regulators experience "end-of-tank dump" — a sudden pressure surge that floods the tank with lethal CO₂ concentration. Fish die, and the spike causes an algae explosion in recovery.

Dual-stage regulators eliminate this by reducing pressure in two stages. Stage 1: cylinder pressure (50–60 bar) → intermediate pressure (8–10 bar). Stage 2: intermediate → working pressure (0.5–1.5 bar). The second stage buffers against cylinder pressure variations.

For competition: invest in a quality dual-stage regulator (Dennerle, UP Aqua, or JBJ). The cost difference versus fish deaths and lost competition months is not a calculation worth making twice.

The solenoid valve — an electronically controlled on/off valve — allows precise scheduling. CO₂ should turn on 1 hour before lights on and off 1 hour before lights off. At night, CO₂ is not consumed by photosynthesis and accumulates dangerously.
"""),
            LessonSection(type: .concept, text: """
**Concept 2: Diffusers, Drop Checkers, and the 24-Hour pH Curve**

The diffuser is where CO₂ meets water. Competition-grade ceramic diffusers (ADA Pollen Glass, UP Aqua diffusers) produce micro-bubbles with high surface area for dissolving efficiency. Replace or citric acid-clean diffusers every 4–6 weeks — bio-fouling and calcium buildup reduce efficiency by up to 40%.

Diffuser placement matters: position at the bottom of the tank, in high-flow areas near the filter inlet or output. CO₂ bubbles should dissolve completely before reaching the surface — if you see bubbles escaping, diffuser output is too high or flow is too low.

The drop checker is your real-time CO₂ monitor. It uses a 4-dKH reference solution and bromothymol blue indicator:
- Blue (>7.0 pH): CO₂ below 15 mg/L — insufficient
- Green (≈6.8 pH): CO₂ ≈ 20–25 mg/L — acceptable  
- Yellow-green (≈6.6 pH): CO₂ ≈ 30 mg/L — optimal
- Yellow (<6.4 pH): CO₂ above 40 mg/L — potentially stressful for fish

The 24-hour pH curve: measure pH every 2 hours for a full day using a calibrated pH meter. The curve reveals whether CO₂ is stable (flat plateau during lights-on) or fluctuating (jagged line indicating pressure issues). Winning tanks have flat, consistent pH curves during the photoperiod.
"""),
            LessonSection(type: .concept, text: """
**Concept 3: CO₂ and Algae — The Stability Relationship**

The most counterintuitive fact in planted competition tanks: CO₂ deficiency causes more algae than CO₂ excess.

When CO₂ drops below threshold during the photoperiod, photosynthesis stalls. Plants in photosynthetic "stress" release organic compounds (root exudates, cellular byproducts) into the water column. These compounds are high-quality food for opportunistic algae. BGA (blue-green algae/cyanobacteria), green dust algae, and staghorn algae explosively colonize tanks recovering from CO₂ interruptions.

The competition implication: never turn off CO₂ for partial days. Never "test" plant response by reducing CO₂. During the critical establishment period (weeks 1–8), CO₂ stability is more important than CO₂ level. A slightly low but consistent CO₂ produces better results than an optimal-but-fluctuating supply.

Stability is the principle. Apply it to every parameter.
"""),
            LessonSection(type: .keyInsight, text: """
**Key Insight — The Night Oxygen Check**

Surface agitation during the night photoperiod (lights off, CO₂ off) allows oxygen exchange. Competition aquascapers check dissolved oxygen at the end of the night period (just before lights on): if DO drops below 6 mg/L, surface agitation is insufficient.

Trick: watch fish behavior at night. If fish gather at the surface or show labored breathing before lights on, oxygen is critically low. Add surface agitation via a small circulation pump or lily pipe directed at the surface.

This is especially critical in densely planted tanks during establishment — plants consuming oxygen at night in a sealed system can crash the tank overnight.
"""),
            LessonSection(type: .example, text: """
**Real-World Application: Dialing In a New Tank**

New 60cm tank, ADA substrate, mixed stems and carpet. Week 1 CO₂ dial-in procedure:

Day 1: Start at 1 bubble per 3 seconds. Place drop checker. Fish showing no stress.
Day 2: Drop checker still blue at midday. Increase to 1 bubble per 2 seconds.
Day 3: Drop checker green. Fish swimming normally. Maintain.
Day 5: Drop checker yellow-green. Optimal. Note regulator working pressure setting.
Day 7: New plant tips showing pearling (oxygen bubbles on leaves) — confirmation of active photosynthesis at correct CO₂ levels.

Now run this for 4 weeks without touching the dial. Stability is the goal. The only adjustment: clean diffuser at week 4 to restore efficiency.
"""),
            LessonSection(type: .summary, text: """
**Summary: CO₂ is Infrastructure, Not a Supplement**

In competitive aquascaping, CO₂ is not an optional enhancement — it's foundational infrastructure, as critical as the filter. Invest in dual-stage regulation. Master the drop checker. Maintain stability above all else.

Every winning aquascape photograph ever taken was backed by a CO₂ system running perfectly for months before that image was captured.

Next lesson: Understanding aquascape composition — how Japanese aesthetic principles create the visual language judges respond to.
"""),
        ], tags: ["intermediate", "CO2", "equipment"]
    )

    // MARK: — Lesson 03

    static let lesson03 = Lesson(
        id: "L03",
        title: "Composition Mastery — The Visual Grammar of Champions",
        subtitle: "Every world-champion aquascape follows a visual logic that can be learned, practiced, and executed deliberately.",
        estimatedMinutes: 15,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: """
Amano once said: "The aquascape should feel like you could walk into it." Not swim — walk. He was describing the Japanese concept of shakkei (借景) — borrowed scenery — where the landscape implies a world beyond the frame.

Every composition technique in competitive aquascaping serves this single goal: creating the convincing illusion of a world that exists beyond the glass. When a judge experiences that illusion involuntarily, the layout wins.
"""),
            LessonSection(type: .concept, text: """
**Concept 1: Compositional Frameworks — Triangle, Concave, Convex**

Competition aquascapes almost universally use one of three primary compositional frameworks:

**Triangle Composition**: Hardscape and plant height create a diagonal line from one low corner to an elevated peak approximately 2/3 across the tank. The focal point sits near the peak. This creates natural visual flow and directionality — the eye enters at the low point and travels to the apex.

**Concave Composition**: Both sides of the tank are elevated; the center dips to create a valley or river channel illusion. Strong depth expression — the low center draws the eye inward, creating a sensation of peering into a landscape. Classic for river biotope and forest ravine themes.

**Convex Composition**: Center is elevated, sides lower. Creates a mountain or island aesthetic. Harder to execute convincingly — the sides must "anchor" visually without appearing empty. Best used with strong foreground carpet that extends the visual base.

The framework should be decided before any substrate or hardscape is placed. Changing compositional structure mid-setup requires starting over. This is not an exaggeration — substrate height creates the terrain, and terrain is architecture.
"""),
            LessonSection(type: .concept, text: """
**Concept 2: The Golden Ratio and Rule of Thirds in 3D Space**

Most aquascapers apply the Golden Ratio as a flat, 2D concept — focal point at 61.8% from the left. Competition-level application extends this into three dimensions.

In a 90cm tank (a common competition size), the Golden Ratio focal point in the X-axis is at approximately 56cm from the left. In the Z-axis (depth), the primary focal point should be positioned at mid-depth (30–40% back from front glass) — not at the back wall, which flattens perspective.

The Rule of Thirds creates three planes of visual interest:
- Foreground plane: carpet plants (Glossostigma, Eleocharis, Monte Carlo), small stones
- Mid-ground plane: primary hardscape, accent plants, the Golden Ratio focal point
- Background plane: tall stem plants that create "sky" and frame the composition

All three planes must be occupied with intention. Empty foreground is dead space. Flat background with no depth layer is a hallway, not a landscape.
"""),
            LessonSection(type: .concept, text: """
**Concept 3: The Odd-Number Principle and Visual Tension**

Takashi Amano derived his stone placement philosophy from ikebana (Japanese flower arranging), which mandates odd-numbered groupings because they inherently create asymmetric tension.

Two stones create balance and rest — the eye stops. Three stones (or five, or seven) create implied movement — the eye travels between them looking for resolution. This unresolved tension is precisely what makes aquascapes feel "alive" rather than static.

The three-stone Iwagumi arrangement (Oyaishi, Fukuishi, Soeishi — main, secondary, companion) is the simplest implementation. The Oyaishi is the largest, positioned off-center at the Golden Ratio point. Fukuishi is smaller, positioned closer to the Oyaishi than the tank edge (maintains visual grouping). Soeishi is smallest, on the opposite side, creating tension between the group and the singleton.

Extended principle: this applies to plant species selection too. Use odd numbers of distinct plant textures and heights. Three textural layers reads as natural; two reads as intentional and artificial; four+ reads as busy.
"""),
            LessonSection(type: .keyInsight, text: """
**Key Insight — Perspective Compression**

Professional competition aquascapers use substrate height manipulation to compress perspective — making a 90cm tank appear to contain a landscape that would realistically require 50 meters of depth.

Technique: substrate rises from 3cm at front to 10–15cm at back. Foreground carpet plants are large-leaved (relatively) — Glossostigma at front. Middle ground uses mid-size plants. Background uses smallest-leaved, finest-textured plants (Hemianthus callitrichoides 'Cuba', Micranthemum sp.). 

The brain interprets decreasing plant size toward the back as distance — identical to how we perceive a forest where distant trees appear smaller. This illusion, executed well, is what "naturalness" scores reward.
"""),
            LessonSection(type: .example, text: """
**Application: Designing a Triangle Composition for 90P (90×45×45cm)**

1. Determine focal point: 90cm × 0.618 = 55.6cm from left. Place main stone at 56cm mark.
2. Establish substrate slope: front left = 3cm, rising to 12cm at back right behind main stone.
3. Hardscape: Oyaishi (largest stone) at focal point, slight forward tilt (3–5°) toward viewer. Fukuishi (60% size) 8cm left and slightly forward. Soeishi (40% size) at right side, 25cm from right edge.
4. Plant framework: Eleocharis carpet across full foreground. Rotala rotundifolia cluster at back right, growing to apex height. Hemianthus callitrichoides in substrate pockets between stones.
5. Background stems fill back left, shorter than Rotala apex, creating triangular silhouette.

Stand back at 1 meter. The triangle should be immediately readable as a compositional shape. If it isn't visible at first glance, the substrate height differential or plant heights are insufficient.
"""),
            LessonSection(type: .summary, text: """
**Summary: Structure Before Beauty**

The most beautiful plants in the world cannot rescue a poorly composed aquascape. Structure — compositional framework, Golden Ratio focal point, odd-number tension, three-plane depth — must be decided, committed to, and executed with precision before the first plant enters the water.

Judge scores for "naturalness" and "impression" are rewards for structural decisions made weeks before the photograph was taken.

Next: Plant Selection for Competition — which species win and why.
"""),
        ], tags: ["intermediate", "composition", "aesthetics"]
    )

    // MARK: — Lesson 04 (abbreviated structure, full content)

    static let lesson04 = Lesson(
        id: "L04",
        title: "The Competitive Plant Palette — Species That Win",
        subtitle: "Not all aquatic plants compete equally. Here's the curated list of species that appear in top-100 IAPLC entries year after year — and why.",
        estimatedMinutes: 13,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: """
The 2022 IAPLC top 10 featured Rotala rotundifolia in 8 out of 10 layouts. Not because aquascapers lack creativity — but because this unassuming pink-red stem plant possesses a combination of growth behavior, color response, and textural flexibility that no other species currently matches for competition work.

Understanding why certain plants dominate competition results teaches you to see plants as compositional tools, not just living decoration.
"""),
            LessonSection(type: .concept, text: """
**Concept 1: Rotala — The Competition Genus**

The Rotala genus dominates competition aquascaping because its members offer three properties simultaneously: fine leaf texture (small leaves create depth and texture contrast), responsive coloration (shifts from green to red-pink based on light intensity and phosphate levels), and predictable growth behavior (stems grow vertical with consistent internode spacing when trimmed correctly).

Key competition species:
- **Rotala rotundifolia**: The workhorse. Adaptable, fast-growing, vivid pink-red under high light. Responds to low phosphate with deeper red coloration. Tolerates wide parameter ranges.
- **Rotala 'H'ra'**: Orange-red with slightly smaller leaves than rotundifolia. More demanding (high CO₂, high light mandatory). More vivid coloration reward.
- **Rotala macrandra**: Large-leafed, deep red-violet. Used as a dramatic accent, not mass planting. High maintenance.
- **Rotala 'Green'**: Fine texture, pale green, excellent for creating natural "background sky" effect. Pairs with red Rotalas for complementary color contrast.
"""),
            LessonSection(type: .concept, text: """
**Concept 2: Carpet Species — The Foundation Layer**

A flawless carpet is the first visual impression a judge receives. Competition carpets are evaluated on: coverage uniformity (no gaps), height consistency (uniform trim plane), color richness, and transition to hardscape (clean interface, no algae at stone edges).

**Hemianthus callitrichoides 'Cuba' (HC)**: The prestige carpet. Smallest leaves of any aquatic carpet plant (1–2mm), creates an otherworldly fine-texture lawn. Extremely demanding: requires CO₂ >25 mg/L, PAR >80 at substrate, soft water. Emersed propagation using DSM is standard practice for competition establishment.

**Glossostigma elatinoides**: More forgiving than HC, coarser texture. Used in large-tank Iwagumi where HC would read as textureless at distance.

**Micranthemum 'Monte Carlo'**: The newcomer that overtook Glossostigma in the 2015–present era. Round leaves, faster growth, more forgiving parameters (80% of HC demands). Now appears in approximately 35% of top-50 IAPLC layouts.

**Eleocharis parvula (mini hairgrass)**: Creates the most convincing grassland/meadow effect. Grows vertically rather than horizontally, making it ideal for triangular compositions where carpet needs to rise naturally into mid-ground.
"""),
            LessonSection(type: .concept, text: """
**Concept 3: Hardscape-Adjacent Plants — The Detail Layer**

The plants placed directly at stone interfaces and between hardscape elements determine whether a composition reads as natural or artificial.

**Riccardia chamedryfolia (Mini pellia)**: A liverwort attached directly to stones and driftwood. Creates the illusion of moss-covered ancient rock. Extremely slow-growing — must be established 6–8 weeks before competition photography.

**Fissidens fontanus**: Fine-textured moss with frond-like appearance. Attached to hardscape with thread or glue. Provides the "forest floor after rain" texture that judges describe as "naturalness."

**Bucephalandra spp.**: Rheophytic plants (native to fast-flowing Borneo rivers) with extraordinary variation. Leaves range from deep green to blue-green to purple. Extremely slow but permanent — once established, needs no trimming. Used in stone crevices for detail interest that rewards close examination.

**Anubias nana 'Petite'**: The smallest Anubias, with 1–2cm leaves. Attached to stone or wood. Provides textural contrast (broad, waxy leaves) against fine-textured surrounding plants.
"""),
            LessonSection(type: .keyInsight, text: """
**Key Insight — Color Temperature and Emotional Impact**

Competition photographs are judged on screen and in print. Color temperature in aquascape photos significantly affects the emotional response judges experience.

Warm-toned layouts (reds, oranges, ambers from Rotala and warm lighting) evoke warmth, fire, autumn, emotional accessibility — scores tend higher for "impression."

Cool-toned layouts (blue-greens, silvers from Vallisneria, Blyxa) evoke water, ice, distance, melancholy — technically admired but emotionally harder to connect with.

Professional competitive aquascapers explicitly choose color temperature as a compositional decision before selecting species. Ask: what emotion does this landscape need to produce in a judge who views it for 30 seconds?
"""),
            LessonSection(type: .example, text: """
**Species Palette for a 60P Triangle Composition:**

Foreground: Hemianthus callitrichoides 'Cuba' (full carpet)
Stone crevices: Fissidens fontanus + Riccardia chamedryfolia  
Mid-ground left: Rotala 'H'ra' (tight cluster, trimmed to dome shape)
Mid-ground right: Bucephalandra 'Brownie Ghost' on stone
Background left: Rotala rotundifolia (vertical mass planting)
Background right: Rotala 'Green' (lighter, creates depth contrast)

Color temperature: warm. Species count: 6. Plant textures: 4 distinct levels (carpet/moss/stem/broadleaf). Complexity: readable in 5 seconds, interesting for 5 minutes.
"""),
            LessonSection(type: .summary, text: """
**Summary: Species are Vocabulary, Composition is Grammar**

Knowing which plants win is not enough — knowing why they win transforms species selection from a shopping decision into a compositional one. Select plants for texture contrast, color temperature, growth behavior, and how they interact with hardscape. Every species in a competition layout earns its place with a specific visual job.
"""),
        ], tags: ["intermediate", "plants", "species selection"]
    )

    // MARK: — Lessons 05–12 (condensed but complete)

    static let lesson05 = Lesson(
        id: "L05",
        title: "Iwagumi — The Philosophy of the Stone Garden",
        subtitle: "The most demanding and most revered style in competitive aquascaping. Three stones. No stems. Total precision.",
        estimatedMinutes: 13,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "An Iwagumi layout has perhaps five elements: three stones, a carpet, and water. It is the hardest aquascape style to execute at competition level because there is nowhere to hide. Every imperfection — an uneven carpet edge, a stone tilted one degree too far, algae at the waterline — is immediately visible. Iwagumi is honest. That's why it wins."),
            LessonSection(type: .concept, text: "**Concept 1: The Three Stones — Oyaishi, Fukuishi, Soeishi**\n\nThe Oyaishi (main stone) is selected first and determines the layout's entire visual hierarchy. Choose it by: maximum visual interest (most complex face), size relative to tank (should occupy 30–40% of the tank height when positioned), and a single dominant directional line (grain or stratification line that creates movement when angled). The Oyaishi tilts slightly (5–10°) toward the viewer — never perfectly vertical, which reads as placed rather than naturally occurring.\n\nFukuishi (secondary stone) is 50–70% the Oyaishi's size. Positioned to share the Oyaishi's 'gravity' — visually grouped with it, as if they fell together. Its face complements, not competes with, the Oyaishi. Soeishi (companion stone) is 30–50% Oyaishi size, placed on the opposite side to create tension across the composition.\n\nAdvanced Iwagumi adds Suteishi (discarded stones) — small accent stones placed deliberately as if naturally tumbled. These transition the eye from hardscape to carpet."),
            LessonSection(type: .concept, text: "**Concept 2: Stone Selection and Matching**\n\nWinning Iwagumi entries use stones from the same geological source — same grain pattern, same color palette, same erosion texture. Mixing stone types reads as collected from different places, destroying the illusion of a natural site.\n\nPrimary competition stones: Seiryu (blue-grey limestone with white veining, slightly alkaline — use with soft water to counteract), Manten (dark volcanic, rough texture, neutral to slightly acidic), Dragon Stone/Ohko (honeycomb-textured sedimentary, warm brown-tan, porous surface ideal for moss attachment), Ryuoh (similar to Seiryu but darker, more dramatic veining).\n\nAll stones from a single layout must be purchased at the same time from the same batch. Color, grain, and weathering vary between batches even of the same stone type."),
            LessonSection(type: .concept, text: "**Concept 3: The Empty Space Is the Layout**\n\nIn Iwagumi, the hardscape is not the layout — the carpet is not the layout. The negative space between and around the stones is the layout. This is the principle of Ma applied to aquascaping.\n\nJudges evaluate Iwagumi by reading the negative space: does the open carpet area create a convincing valley, meadow, or river bed? Does the space around the stones feel breathable or cramped? Is there a sense of air, even in an underwater environment?\n\nPractical execution: once stones are placed, photograph the empty tank from competition eye level. Study the negative space shapes. If they read as accidental or awkward, reposition before planting. The carpet will not fix a compositional problem — it will only reveal it."),
            LessonSection(type: .keyInsight, text: "**Key Insight**: An Iwagumi that fails does so because the aquascaper placed the stones quickly and expected plants to compensate. Amano reportedly spent entire days arranging stones before committing. The ratio of time spent on stone placement to the total setup time should be at least 1:3."),
            LessonSection(type: .example, text: "**Pre-photography Iwagumi checklist**: Stone faces clean (remove all algae with old toothbrush + diluted hydrogen peroxide). Carpet trimmed to exactly 5mm height with aquascape scissors, flat plane. No visible substrate showing through carpet. Waterline streak-free (razor blade clean). CO₂ pearling visible on carpet in macro photography. Drop checker yellow-green. Front glass polished from inside with magnetic cleaner 1 hour before photography."),
            LessonSection(type: .summary, text: "Iwagumi demands the most of the aquascaper and rewards it with the purest expression of natural landscape in a glass box. Master it and you understand everything about competitive aquascaping. Struggle with it and you learn exactly which skills still need development."),
        ], tags: ["intermediate", "iwagumi", "style", "composition"]
    )

    static let lesson06 = Lesson(
        id: "L06",
        title: "Dutch Style — The Structured Garden Reborn",
        subtitle: "The oldest competition style in aquascaping is experiencing a global renaissance. Here's why Dutch is winning again.",
        estimatedMinutes: 12,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "In 2018, a Dutch aquascape placed in the IAPLC top 30 for the first time in over a decade. Judges described it as 'a return to intentional complexity.' Dutch aquascaping never disappeared — but its formal, architectural approach fell out of fashion during the nature aquarium era. Now, with a new generation reinterpreting Dutch rules with modern species and lighting technology, the style is winning again."),
            LessonSection(type: .concept, text: "**Concept 1: The Dutch Street**\n\nThe defining feature of Dutch aquascaping is the 'Dutch street' (straat) — a linear planting row of a single species, running front-to-back, creating the illusion of a garden path or corridor. A classic Dutch layout contains 2–4 streets, each using a different species with clearly contrasting leaf shape, size, and color.\n\nStreet rules: no two adjacent streets may use the same genus. Each street must have clearly defined edges — surrounding species must not invade. Height contrast between streets is mandatory (a tall street next to a low street creates the stepped terrace effect Dutch is known for).\n\nModern Dutch interpretation relaxes strict linearity while maintaining the core contrast principle: structured, intentional differentiation between plant groups, with each group given its own defined territory."),
            LessonSection(type: .concept, text: "**Concept 2: Species Contrast Principles**\n\nDutch judging evaluates contrast on four axes:\n1. **Leaf shape**: round vs. needle vs. broad vs. compound\n2. **Leaf size**: micro (< 1cm) vs. small (1-3cm) vs. large (>3cm)\n3. **Color**: red/orange vs. green vs. yellow-green (never adjacent same-color)\n4. **Texture**: glossy vs. matte vs. pubescent (hairy)\n\nAchieving contrast on all four axes simultaneously creates maximum visual richness. A classic combination: Ammania gracilis (narrow red-orange, medium leaf) adjacent to Limnophila aromatica (green, medium compound leaf) adjacent to Echinodorus tenellus (narrow bright green, lance-shaped). Three completely different axes of contrast."),
            LessonSection(type: .concept, text: "**Concept 3: The Focal Point Red Plant**\n\nEvery Dutch layout traditionally features one red 'crown jewel' species as the composition's emotional apex — positioned at the Golden Ratio point, tall enough to command the full tank height. Historically this was Alternanthera reineckii; modern competition Dutch uses Ammania sp. 'Bonsai,' Ludwigia glandulosa, or Rotala macrandra for more vivid red-violet.\n\nThe focal red plant earns its position through contrast: it must be surrounded by greens and yellow-greens that make the red appear to glow by simultaneous contrast (complementary colors on the color wheel intensify each other when adjacent)."),
            LessonSection(type: .keyInsight, text: "**Key Insight — Dutch Scoring Criterion 'Craftsmanship'**: Dutch competitions (NBAT, AquaDesign competitions) score 'craftsmanship' as the highest-weighted category — clean plant edges, trimmed interfaces, zero algae, perfect water clarity. The aesthetic vision is secondary to the technical execution quality. Dedicate 40% of total setup time to maintenance and trimming precision."),
            LessonSection(type: .example, text: "**Species list for a 120cm Dutch layout**: Background (120cm full width): Vallisneria americana (vertical linear texture, tall). Mid-back left street: Ammania gracilis (red-orange crown). Mid-back right street: Limnophila hippuridoides (green compound leaf contrast). Mid-ground center: Rotala 'H'ra' group. Mid-ground left: Cryptocoryne wendtii 'Green' (broad dark green). Mid-ground right: Lobelia cardinalis (rounded bright green). Foreground: Pogostemon helferi (star-shaped rosette, bright green). Total: 7 species, 7 distinct contrasts."),
            LessonSection(type: .summary, text: "Dutch aquascaping is the discipline of intentional contrast executed with craft-level precision. It rewards systematic thinking — plan species lists on paper before purchasing a single plant. Every species decision is structural, not decorative."),
        ], tags: ["intermediate", "dutch style", "history"]
    )

    static let lesson07 = Lesson(
        id: "L07",
        title: "Light — The Engine of Competition Growth",
        subtitle: "PAR, PUR, and spectrum: how to build a lighting system that makes competition plants perform at their physiological maximum.",
        estimatedMinutes: 11,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "Two identical tanks. Same substrate, same plants, same CO₂, same fertilization. One uses a $80 LED strip. One uses a $600 competition-grade LED panel. At week 8, the cheap-light tank has stunted carpets, limited coloration, and algae along the back. The expensive-light tank has a flawless HC carpet and Rotala 'H'ra' glowing orange-red. The light wasn't expensive — it was the cheapest possible investment for the result."),
            LessonSection(type: .concept, text: "**Concept 1: PAR vs. PUR vs. PPF**\n\nPAR (Photosynthetically Active Radiation) measures light intensity in the 400-700nm wavelength range in µmol/m²/s. This is the standard metric aquascapers use.\n\nPUR (Photosynthetically Usable Radiation) is more accurate — it measures only the wavelengths plants actually absorb efficiently (chlorophyll absorption peaks at 430–450nm blue and 640–680nm red). A light with high PAR but poor spectrum distribution may have low PUR — it's 'bright' but not 'useful.'\n\nPPF (Photosynthetic Photon Flux) measures total output of a fixture in µmol/s. Divide PPF by tank surface area to estimate PPFD (Photosynthetic Photon Flux Density) — the actual PAR at a given depth.\n\nFor competition work, target: 80–120 µmol/m²/s at substrate level for demanding carpet species (HC, Glossostigma). 40–80 µmol/m²/s is acceptable for less demanding species."),
            LessonSection(type: .concept, text: "**Concept 2: Spectrum Engineering for Coloration**\n\nRed spectrum (640–680nm) drives chlorophyll-A photosynthesis efficiency and red-pink pigment expression in Rotala and Ludwigia species. Blue spectrum (430–460nm) drives chlorophyll-B, promotes compact internodal spacing (tight, dense stem growth), and enhances blue-green coloration in Bucephalandra.\n\nCompetition lights balance red and blue (typically 3000–6500K color temperature) to simultaneously maximize growth rate (red dominance) and compact structure (blue influence).\n\nSpecific recommendation: ADA Solar RGB, Twinstar E series, or Chihiros WRGB series provide independently adjustable red, green, and blue channels, allowing aquascapers to dial color temperature per tank. For Iwagumi with warm stone: boost warm/red channel. For cool biotope: boost blue/cool channel."),
            LessonSection(type: .concept, text: "**Concept 3: Photoperiod Strategy**\n\nNew tank establishment (weeks 1–4): 6 hours maximum. This limits algae access to light energy while plants establish root systems. Algae thrive with light; plant roots need time, not light.\n\nEstablished tank (week 5+): ramp to 8 hours over 2-week period. Never jump from 6 to 10 hours — the plant-to-algae light exposure ratio must shift gradually.\n\nCompetition peak period (final 4 weeks before photography): 8–9 hours at full intensity. Consistent timing every day (±5 minutes via smart outlet timer). Plants entrain to photoperiod — inconsistent scheduling disrupts biological rhythms and reduces photosynthetic efficiency."),
            LessonSection(type: .keyInsight, text: "**Key Insight — The Siesta Period**: Some competition aquascapers use a 'siesta' lighting schedule: 5 hours on → 2 hours off → 3 hours on. The rationale: CO₂ depletes during the first morning session. The 2-hour off period allows CO₂ to recover and oxygen to off-gas. The afternoon session then resumes with full CO₂ availability. Evidence is anecdotal but the practice appears in several top-20 IAPLC methodology descriptions."),
            LessonSection(type: .example, text: "**Lighting setup for 60P (60×30×36cm)**: 1× Twinstar 600E at 80% intensity (measures ~90 µmol/m²/s at substrate). Timer: on at 09:00, off at 13:00 (siesta), on at 15:00, off at 19:00. Total: 8 hours. Red channel: 70%. Blue channel: 55%. Green channel: 40%. Color temperature: approximately 6000K. CO₂ begins at 08:00 (1 hour before first light period)."),
            LessonSection(type: .summary, text: "Light is the one parameter you cannot compensate for with anything else. Under-lit tanks produce elongated, pale, algae-prone results regardless of how perfect the water chemistry or fertilization. Invest in measurable, spectrally appropriate, timer-controlled lighting before worrying about any other equipment upgrade."),
        ], tags: ["intermediate", "lighting", "equipment"]
    )

    static let lesson08 = Lesson(
        id: "L08",
        title: "Fertilization Protocols — Feeding the Competition Tank",
        subtitle: "EI, PPS-Pro, and lean dosing: three philosophies, one goal — optimal plant nutrition without feeding algae.",
        estimatedMinutes: 12,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "The planted tank fertilization debate has been ongoing since the 1990s. EI (Estimative Index) vs. PPS-Pro (Perpetual Preservation System) vs. 'lean dosing' — aquascapers argue about these systems with religious fervor. The truth: all three systems work for competition tanks when applied correctly and consistently. What doesn't work is switching systems mid-growth-period, under-dosing due to fear of algae, or over-dosing as a substitute for diagnosing root causes."),
            LessonSection(type: .concept, text: "**Concept 1: Estimative Index (EI) — Tom Barr's System**\n\nEI principle: dose more nutrients than plants can consume, creating a constant surplus. Algae cannot exploit a nutrient surplus without light; plants grow optimally in surplus. The weekly 50% water change resets any toxic buildup and provides a dosing 'reset' point.\n\nStandard EI macro dosing (60-gallon tank, 3× per week): KNO₃ (potassium nitrate) 2g provides NO₃ and K. KH₂PO₄ (monopotassium phosphate) 0.5g provides PO₄ and K. K₂SO₄ (potassium sulfate) 2g provides additional K. Alternate days: trace element solution (Flourish, EDTA trace mix).\n\nEI advantages: forgiving, self-correcting via water change, no testing required. EI disadvantages: high water change volume (practical issue for large competition tanks over 200L), requires reliable source of remineralized RO water."),
            LessonSection(type: .concept, text: "**Concept 2: PPS-Pro — Precision Maintenance Dosing**\n\nPPS-Pro (Greg Moeller's system) doses nutrients daily at the exact rate plants consume them. No surplus, no deficiency — theoretical equilibrium. Requires initial calibration period (4–6 weeks of observing deficiency symptoms and adjusting) but thereafter requires minimal water changes (20% weekly rather than 50%).\n\nThe core PPS-Pro insight: algae cannot explosively colonize a tank where nutrients are never in surplus, because there's nothing to exploit. The system's weakness: it requires the aquascaper to accurately read plant deficiency symptoms and dial doses accordingly. Misread a deficiency and under-dose for 2 weeks — the plants suffer and algae exploits the stressed plants' exudates.\n\nBest for: experienced aquascapers who can read plant health accurately. Poor choice for beginners."),
            LessonSection(type: .concept, text: "**Concept 3: Lean Dosing — Competition-Specific Adaptation**\n\nLean dosing runs nutrients at the lower bound of sufficiency — enough to prevent deficiency, never enough to create surplus. The goal is to deny algae opportunistic nutrition while maintaining plant health.\n\nLean dosing is inherently high-risk: the margin between 'sufficiently lean' and 'deficiency-causing' is narrow and varies with growth rate, which varies with season, temperature, and plant mass. A tank that runs perfectly lean in winter may show deficiencies in summer as plant metabolic rates increase.\n\nCompetition aquascapers who use lean dosing exclusively test water weekly (NO₃, PO₄, K at minimum) and adjust dosing based on results. This is the most technically demanding approach but produces the cleanest-looking water and lowest algae risk when executed correctly."),
            LessonSection(type: .keyInsight, text: "**Key Insight — The Phosphate Myth**: Many beginners fear phosphate as an algae driver and deliberately under-dose PO₄. Research (Sears & Conlin, 1996; Tom Barr's studies) demonstrates that phosphate does not cause algae in the presence of adequate CO₂ and balanced nutrients. Phosphate-starved plants are MORE susceptible to algae (cellular stress → exudate production) than well-nourished plants. Do not under-dose phosphate."),
            LessonSection(type: .example, text: "**Starting EI protocol for a new 90P (90×45×45cm, ~180L):**\nMonday/Wednesday/Friday: 4g KNO₃ + 1g KH₂PO₄ + 3g K₂SO₄, dissolved in 500ml RO water, added to tank\nTuesday/Thursday/Saturday: 15ml Seachem Flourish Comprehensive (trace elements)\nSunday: 50% water change with remineralized RO (target GH 5, KH 3)\nRun this protocol for 8 weeks without modification. Observe plant health. If NO₃ tests above 40ppm after 1 week, reduce KNO₃ to 3g. If below 10ppm, increase to 5g."),
            LessonSection(type: .summary, text: "Choose your fertilization system and commit to it for a minimum of 8 weeks before evaluating results. The biggest fertilization mistake in competition aquascaping is not the wrong system — it's switching systems every 2 weeks because the tank isn't perfect yet. Give the system, the plants, and the water chemistry time to reach equilibrium."),
        ], tags: ["intermediate", "fertilization", "nutrients"]
    )

    static let lesson09 = Lesson(
        id: "L09",
        title: "Algae in Competition — The Adversary as Diagnostic Tool",
        subtitle: "Every algae type is a specific message about what's wrong in your system. Learn to read algae instead of fighting it blindly.",
        estimatedMinutes: 13,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "Professional aquascapers don't hate algae — they read it. Every algae species that appears in a competition tank is a symptom of a specific imbalance, as diagnostic as a blood test. The aquascaper who sees green dust algae on the front glass and immediately knows to check CO₂ stability has a fundamental advantage over the one who simply scrubs it and wonders why it returns."),
            LessonSection(type: .concept, text: "**Concept 1: Green Dust Algae (GDA) — The New Tank Alarm**\n\nGreen dust algae forms as a thin, smooth, bright green coating on glass surfaces. It's almost exclusively a new-tank phenomenon (weeks 1–8) and indicates: unstable or insufficient CO₂, excessive light relative to plant mass, or organic load from decomposing plant tissue during establishment.\n\nGDA strategy: do NOT wipe glass during active GDA bloom. GDA has a 3–4 week lifecycle. Wiping glass releases spores and restarts the cycle. Instead: identify root cause (CO₂ check, light reduction), fix it, and wait for the GDA bloom to complete its lifecycle and crash naturally. After the bloom crashes, a single thorough glass cleaning removes all residue permanently (assuming root cause was fixed). Competition aquascapers who understand this save 3 weeks of frustration."),
            LessonSection(type: .concept, text: "**Concept 2: Black Beard Algae (BBA) and Staghorn — CO₂ Signals**\n\nBBA (Audouinella sp.) is a red algae that appears as dense dark tufts on slow-growing plant edges, hardscape, and equipment. It is definitively caused by CO₂ fluctuation — not deficiency, but inconsistency. A tank with 20 mg/L stable CO₂ will not develop BBA. A tank fluctuating between 10 and 35 mg/L will become covered in it within weeks.\n\nDiagnosis: check CO₂ timing (solenoid malfunctions), diffuser cleanliness (intermittent blockage), and whether water surface agitation is excessive (off-gasses CO₂ before plants can absorb it).\n\nTreatment: target the root cause first. Then spot-treat BBA-affected areas with diluted glutaraldehyde (Seachem Excel, 5mL per 100L, spot-dosed with syringe directly onto BBA while reducing pump flow). BBA turns red when dying, then white, then is consumed by nerite snails or simply removed.\n\nStaghorn algae (grey, single-strand branches) indicates the same root cause as BBA: CO₂ instability, often at tank startup or after equipment changes."),
            LessonSection(type: .concept, text: "**Concept 3: Cyanobacteria (BGA) — The Soil Warning**\n\nBlue-green algae (technically cyanobacteria, not true algae) forms as slimy blue-green sheets on substrate, plants, and hardscape. Its distinct musty smell is immediately recognizable. BGA is a nitrogen cycle signal: low nitrogen relative to other nutrients, particularly in new tanks where NO₃ hasn't stabilized.\n\nIn competition tanks, BGA most commonly appears in the first 4 weeks, in areas of low flow (behind hardscape, at substrate edges). Management: increase flow across affected areas, dose additional KNO₃, and consider targeted treatment (1-week blackout or erythromycin as absolute last resort before competition — antibiotic treatments disrupt biological filtration).\n\nPrevention: ensure filter flow rate turns over tank volume at least 8–10× per hour. Dead spots in flow patterns are BGA habitat."),
            LessonSection(type: .keyInsight, text: "**Key Insight — The Algae Priority Order**: When multiple algae types appear simultaneously, fix in order: BGA first (nitrogen cycle issue), then BBA/Staghorn (CO₂ stability), then GDA (light/CO₂ ratio in new tank). Fixing BBA while ignoring BGA is reverse priority — the systemic issue (nitrogen cycle) must be resolved before fine-tuning CO₂."),
            LessonSection(type: .example, text: "**Algae diagnostic flowchart for competition use**:\nNew tank, week 3: GDA on glass → expected, do not wipe, check CO₂, wait.\nWeek 5: BBA on Rotala edges → check solenoid valve schedule, clean diffuser, verify CO₂ timing.\nWeek 6: BGA patch behind left stone → add small circulation pump aimed at dead spot, increase NO₃ dose.\nWeek 8: GDA cleared (natural lifecycle complete), BBA receding after CO₂ fix, BGA eliminated → tank entering clean phase. Final 4 weeks of growth should be algae-free."),
            LessonSection(type: .summary, text: "Algae is information. The aquascaper who panics and does blackouts, overdoses hydrogen peroxide, and strips down the tank at the first GDA outbreak is the one who never submits competition photos. The aquascaper who reads the algae type, identifies the root cause, and applies the specific fix is the one who does. Calm diagnosis over reactive treatment, always."),
        ], tags: ["intermediate", "algae", "troubleshooting"]
    )

    static let lesson10 = Lesson(
        id: "L10",
        title: "Photography and Submission — Turning Months of Work into One Image",
        subtitle: "The photograph is the competition entry. Not the tank. Everything in the final 72 hours is about the photograph.",
        estimatedMinutes: 10,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "A world-class aquascape photographed poorly will score worse than a competent aquascape photographed expertly. IAPLC judges examine high-resolution digital files — at 100% zoom, they see every algae speck, every floating particle, every lens distortion artifact. The photography session is not documentation of your work. It is the last design decision you make."),
            LessonSection(type: .concept, text: "**Concept 1: Equipment and Settings**\n\nCamera: full-frame mirrorless or DSLR mandatory for competition-serious submissions. Crop sensor cameras lack sufficient dynamic range to capture deep shadow detail in aquascape glass simultaneously with bright plant highlights. Minimum: Sony A7 series, Nikon Z series, Canon R series.\n\nLens: 24–70mm f/2.8 or prime equivalent. Focal length 35–50mm at competition distance (1.5–3m from tank) minimizes perspective distortion. Avoid ultra-wide (< 24mm) — barrel distortion curves the straight glass edges, immediately readable as photographic artifact by judges.\n\nSettings baseline: aperture f/8–f/11 (maximizes depth of field, all planes sharp), ISO 400–800 (newer sensors handle 800 cleanly), shutter speed set by light meter for correct exposure. Manual mode mandatory — auto mode creates inconsistent exposure between shots."),
            LessonSection(type: .concept, text: "**Concept 2: Tank Preparation Protocol**\n\n72 hours before: 30% water change to reduce visible organic particles. Trim all plants to final competition height — allow 3 days for trimming cuts to seal (fresh cuts produce micro-bubbles that appear as white dots in photographs).\n\n24 hours before: clean all glass surfaces inside with magnetic cleaner. Inspect back and side glass for algae — treat with razor blade at water level.\n\n3 hours before: increase CO₂ to trigger pearling on carpet plants (pearling visible in photo = active photosynthesis = plant health signal to judges). Reduce water surface agitation to minimum (still water reflects less, photograph clarity improves).\n\n1 hour before: final front glass polish with clean microfiber from inside, then outside. Remove any water splash marks above waterline. Check CO₂ drop checker: must be yellow-green in photograph frame."),
            LessonSection(type: .concept, text: "**Concept 3: Lighting and Background**\n\nExternal room lighting: turn off all room lights during photography. Tank lighting only. External light sources create color casts and reflections on glass that are impossible to remove in post-processing.\n\nBackground: competition rules typically require plain black or white background. Black (most common): eliminates light bleed from behind tank, creates maximum contrast with plants. Use black foam board or blackout fabric against back of tank, not the built-in background — built-in backgrounds are rarely uniformly flat.\n\nPost-processing (minimal): white balance correction (set manually in-camera to tank light Kelvin rating for most accurate color), slight contrast increase (+5–10%), clarity (+5%). Do not sharpen artificially, do not increase vibrance/saturation beyond +10% — IAPLC submission guidelines state that digitally manipulated entries are disqualified."),
            LessonSection(type: .keyInsight, text: "**Key Insight — The One-Hour Window**: Aquascapes peak visually 90–120 minutes after CO₂ is at full saturation during the photoperiod. Plants are actively pearling, colors are most vivid, and water is at maximum clarity (CO₂ micro-bubbles have dissolved). This is the photography window. Schedule the entire photography session to align with this 90-minute peak — it cannot be extended."),
            LessonSection(type: .example, text: "**Competition photography session timeline**:\n08:00 — CO₂ on, room lights off\n09:00 — Tank lights on (pearling begins at ~09:45)\n09:30 — Final glass clean, camera on tripod, frame composed, exposure locked\n09:45 — Test shots, review at 100% on laptop for particle focus and clarity\n10:00 — Photography session: 50+ shots at various exposures, select 5 best\n10:30 — Photography complete. Tank back to normal maintenance.\nSelect final submission image: highest sharpness at front carpet, no blown highlights on pearl bubbles, color temperature matching ADA standard (approximately 6500K neutral)."),
            LessonSection(type: .summary, text: "The aquascaper who understands that the photograph is the final creative decision scores better than the one who treats photography as paperwork. Every second of the final 72 hours is in service of one image. Respect the camera time as much as the growing time."),
        ], tags: ["expert", "photography", "competition"]
    )

    static let lesson11 = Lesson(
        id: "L11",
        title: "Filter Systems — Invisible Infrastructure That Wins Championships",
        subtitle: "You will never see a competition tank's filter. But its performance determines whether the photograph is taken in week 12 or week 20.",
        estimatedMinutes: 11,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "The filter is the organ. The aquascape is the body. Judges never see the organ — but a failed organ means no body to judge. Competition aquascapers treat filtration as the foundational infrastructure investment, not an afterthought, and size it aggressively beyond minimum specifications."),
            LessonSection(type: .concept, text: "**Concept 1: Flow Rate, Turnover, and the Competition Standard**\n\nThe standard recommendation for planted aquariums is 5–8× tank volume turnover per hour. Competition aquascapers run 8–12× turnover. The difference: higher flow delivers CO₂ and nutrients to plant surfaces faster (boundary layer disruption), removes organic waste before it settles and decomposes, and maintains more uniform temperature and chemistry throughout the water column.\n\nFor a 90P (approximately 180L working volume): minimum filter flow 1440L/h (8×). Recommended: two external filters totaling 2000–2400L/h. The redundancy also provides biological filtration failsafe — a single filter failure doesn't crash the nitrogen cycle.\n\nFilter type for competition: external canister filters (Eheim 2217, Oase BioMaster, Fluval FX) offer the best combination of biological capacity, mechanical filtration, and silent operation. Internal filters create surface disturbance and are impractical for large tanks. Sump systems offer maximum volume but require tank drilling and add complexity."),
            LessonSection(type: .concept, text: "**Concept 2: Filter Media Stack for Competition**\n\nCompetition filter media is designed for biological completeness and minimal maintenance interval (keeping hands out of the tank during critical growth phases):\n\nLayer 1 (coarse): Blue foam or coarse filter floss — mechanical pre-filtration, catches large debris. Replace or rinse every 4–6 weeks. Never discard biological media in same cleaning session.\n\nLayer 2 (biological primary): High-porosity ceramic rings (Seachem Matrix, Fluval Bio-Max) or sintered glass (Ehfisubstrat Pro). Provides enormous surface area for nitrifying bacteria (Nitrosomonas, Nitrobacter). Never replace — add if needed, rinse only in old tank water to preserve bacterial populations.\n\nLayer 3 (biological secondary): Fine foam or porous bio-balls — additional bacterial surface area. Low maintenance.\n\nLayer 4 (polishing): Fine filter floss or micron pad — removes micro-particles for crystal clarity. Replace every 2–3 weeks — clogged fine media creates dead spots and anoxic conditions.\n\nNo activated carbon in competition tanks: activated carbon removes fertilizer trace elements and is not needed in healthy planted systems."),
            LessonSection(type: .concept, text: "**Concept 3: Inlet/Outlet Placement and Flow Dynamics**\n\nFlow pattern in a competition tank must: distribute CO₂ uniformly across all plant surfaces, prevent dead spots (where BGA develops), and create gentle flow across the carpet (strong enough to prevent sedimentation, gentle enough not to uproot recently planted HC or Glossostigma).\n\nClassic competition placement: Lily pipe outlet (glassware, not plastic — reduces visual intrusion in photographs) at one end of the tank, aimed at the surface at a slight downward angle to create circular flow. Inlet at the opposite end, near the substrate.\n\nSurface movement: minimal during the photography period (days before competition photo), maximized during normal maintenance periods (improves oxygen exchange, CO₂ off-gassing management at night)."),
            LessonSection(type: .keyInsight, text: "**Key Insight**: Clean filter media before starting any new competition tank. Fresh media on an established filter is fine — never transfer established media to a new filter without running a quick ammonia cycle check (3–5 days, add ammonia source, verify 0 ammonia + 0 nitrite). A filter crisis in week 3 of a competition grow costs you 3 weeks of irreplaceable growth."),
            LessonSection(type: .example, text: "**Filter setup for 90P competition tank**: Primary: Eheim 2217 (1000L/h rated, 800L/h realistic at head pressure) running Matrix + Ehfisubstrat Pro + fine floss. Secondary: Oase BioMaster 350 (350L/h) running fine Matrix for polishing. Total flow: ~1150L/h = 6.4× (acceptable, target for 8× with upgrade). Glass lily pipe inlet (right side, midwater), glass outlet with surface skimmer (left side). CO₂ input injected via T-junction into secondary filter inlet — CO₂ dissolves in filter chamber for maximum efficiency."),
            LessonSection(type: .summary, text: "The filter is never seen in a competition photograph. The water clarity it creates, the nutrient distribution it enables, and the biological stability it maintains — these are visible in every square centimeter of the winning image. Infrastructure first. Beauty second."),
        ], tags: ["intermediate", "filtration", "equipment"]
    )

    static let lesson12 = Lesson(
        id: "L12",
        title: "The 16-Week Championship Timeline — A Complete Competition Preparation Guide",
        subtitle: "Week by week, from dry hardscape to submitted photograph. This is the professional roadmap.",
        estimatedMinutes: 15,
        xpReward: 40,
        content: [
            LessonSection(type: .hook, text: "Winning at IAPLC is not about inspiration — it's about execution against a timeline. The aquascapers who consistently place in the top 100 treat competition preparation like professional production schedules: every week has specific deliverables, every decision has a deadline, and improvisation is planned for. This lesson is the master timeline."),
            LessonSection(type: .concept, text: "**Weeks 1–2: Foundation Phase**\n\nWeek 1, Day 1: Finalize compositional framework (triangle, concave, convex). Source and select all hardscape. Arrange hardscape completely dry in empty tank. Photograph from competition angle. Sleep on it. Adjust. Commit.\n\nWeek 1, Day 2–3: Place substrate layers (Power Sand base, Aqua Soil cap). Final hardscape placement over substrate — embed stones to stable depth. Photograph. If composition doesn't read perfectly, adjust now. After water fill, major repositioning disturbs substrate and releases turbidity that takes days to clear.\n\nWeek 1, Day 4: Fill tank slowly using a plate or bag to prevent substrate disturbance. Water will cloud — normal. Run filter immediately. Start CO₂ at low rate (1 bubble per 5 seconds) during daylight hours.\n\nWeek 1, Days 5–7: Water clearing. Minor cloudiness from new Aqua Soil is expected. Do not do water changes yet — bacterial seeding is establishing. Light: 6 hours, 60% intensity. CO₂: maintain low.\n\nWeek 2: Begin DSM (Dry Start Method) if using HC carpet. Reduce water level to 2cm below hardscape tops. Mist twice daily. Keep tank sealed with cling film at 85%+ humidity. HC planted in emersed form — roots establish without submersion stress."),
            LessonSection(type: .concept, text: "**Weeks 3–6: Establishment Phase**\n\nWeek 3–4 (if DSM): Continue misting, monitor carpet coverage. HC should show lateral runners at week 3. BGA may appear in DSM environment — improve airflow, mist less frequently.\n\nWeek 4: If fully submersed from day 1: expect algae bloom period. DO NOT intervene aggressively. Monitor CO₂ (dial to drop checker yellow-green). Limit light. Add algae crew: Otocinclus (×5 for 90P), Amano shrimp (×20), Nerite snails (×5). These consume algae 24/7 without competing with plants.\n\nWeek 5: First plant additions (stems, moss attachments). Start EI or chosen fertilization protocol. Water change 50%. Begin ramping light to 7 hours.\n\nWeek 6: Carpet coverage checkpoint — HC/Monte Carlo should show 60%+ coverage. Any gap areas: replant small portions. Stem plants beginning to show growth rate acceleration as substrate matures."),
            LessonSection(type: .concept, text: "**Weeks 7–12: Growth and Refinement Phase**\n\nWeeks 7–8: First major trim of stem plants. Cut to 50% height, replant tops into substrate for density. Begin weekly trimming rhythm: maintain silhouette shape established in compositional plan. The silhouette must be readable and intentional from now until photography.\n\nWeeks 9–10: Carpet at 90%+ coverage target. Any remaining gaps signal parameter issue — address immediately. Detailed algae inspection: at this stage, BBA or staghorn indicates CO₂ issue requiring resolution before week 12.\n\nWeek 10–11: Final hardscape detail adjustments — add moss attachments (Fissidens, Riccardia), Bucephalandra insertions into stone crevices. These establish in 3–4 weeks before photography.\n\nWeek 12: Competition milestone checkpoint. Photograph the tank. Compare to your compositional sketches from Week 1. Is the silhouette executed? Is depth expression visible? Are plant colors at target? Note three specific improvements and implement."),
            LessonSection(type: .concept, text: "**Weeks 13–16: Competition Finalization Phase**\n\nWeek 13–14: Maintain, do not change. Weekly trims maintaining silhouette. 50% water changes. EI dosing continues. No new plants, no hardscape changes. The composition must now 'mature' — substrate bacteria fully established, plant root systems extensive, water chemistry at peak stability.\n\nWeek 14: Identify the photography date (for IAPLC: March 31 submission deadline, photograph in March). Schedule back from that date.\n\nWeek 15: Final trim 10 days before photography. This gives 10 days for trim wounds to heal and new growth to begin (fresh growing tips are vivid, photogenic). Increase CO₂ slightly to encourage pearling.\n\nWeek 16, Day -3: 30% water change. Clean all glass. Final algae removal from hardscape. Begin photography preparation protocol (see Lesson 10)."),
            LessonSection(type: .keyInsight, text: "**Key Insight — The Irreversibility Principle**: The most important decision in this 16-week timeline is the compositional decision made in Week 1. Every subsequent week builds on that foundation. If the composition is structurally flawed, no amount of plant quality, water chemistry, or photography skill compensates. Spend disproportionate time on Weeks 1–2. Everything else is execution."),
            LessonSection(type: .example, text: "**Competition self-assessment rubric for Week 12 checkpoint**:\n- Compositional framework readable in 5 seconds from 2m distance: YES/NO\n- Primary focal point (Oyaishi or crown plant) immediately draws eye: YES/NO  \n- Three depth planes clearly distinct: YES/NO\n- Carpet at 90%+ coverage, uniform height: YES/NO\n- Stem plants at planned silhouette, no unintended gaps: YES/NO\n- CO₂ drop checker yellow-green during photoperiod: YES/NO\n- Zero BBA/Staghorn present: YES/NO\n- Water clarity: can read text through 90cm tank: YES/NO\nTarget: all YES. Any NO items get 4 weeks to resolve before photography."),
            LessonSection(type: .summary, text: "The 16-week timeline is not a rigid script — it's a decision framework. Every competition tank is different. But the phases are universal: foundation, establishment, growth, finalization. Skip a phase by rushing and you compress the timeline's logic, usually resulting in photography of an incomplete work.\n\nThe aquascapers consistently in the top 100 have run this process enough times that it's internalized. Every setup decision they make is contextualized within the timeline. That's the difference between a beautiful hobby tank and a competition entry.\n\nYou now have the complete knowledge architecture. The rest is repetition, refinement, and the particular patience that competitive aquascaping demands and rewards."),
        ], tags: ["expert", "competition preparation", "timeline"]
    )
}
