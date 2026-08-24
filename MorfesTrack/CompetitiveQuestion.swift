import Foundation

// MARK: — Models
struct CompetitiveQuestion: Identifiable {
    let id: String
    let lessonID: String?          // nil = general / fact-based
    let difficulty: Difficulty
    let question: String
    let options: [String]          // always 4
    let correctIndex: Int
    let explanation: String
    let tags: [String]

    enum Difficulty: String {
        case beginner, intermediate, expert
        var xpReward: Int {
            switch self {
            case .beginner:     return 10
            case .intermediate: return 20
            case .expert:       return 35
            }
        }
    }
}

// MARK: — Bank
enum CompetitiveQuestionBank {

    static let all: [CompetitiveQuestion] = [

        // MARK: Water Chemistry (L01)
        CompetitiveQuestion(
            id: "Q001", lessonID: "L01", difficulty: .beginner,
            question: "What does KH measure in aquarium water?",
            options: ["General mineral hardness", "Carbonate hardness (buffering capacity)", "Total dissolved solids", "Potassium concentration"],
            correctIndex: 1,
            explanation: "KH (carbonate hardness) measures the buffering capacity of water — its resistance to pH change. Higher KH means pH is more stable but requires more CO₂ to lower it.",
            tags: ["water chemistry", "KH", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q002", lessonID: "L01", difficulty: .intermediate,
            question: "At KH = 4 dKH, a pH of 6.6 corresponds to approximately how much dissolved CO₂?",
            options: ["10 mg/L", "25 mg/L", "44 mg/L", "60 mg/L"],
            correctIndex: 2,
            explanation: "Using the pH-KH-CO₂ relationship table, KH 4 dKH at pH 6.6 = approximately 44 mg/L CO₂ — effective for plants but approaching the upper safety limit for fish.",
            tags: ["water chemistry", "CO2", "KH", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q003", lessonID: "L01", difficulty: .intermediate,
            question: "Magnesium deficiency in aquatic plants most commonly shows as:",
            options: ["Distorted new growth", "Interveinal chlorosis on older leaves", "Black leaf edges", "Stunted root growth only"],
            correctIndex: 1,
            explanation: "Magnesium is mobile in plants — when deficient, the plant relocates it to new growth first. Interveinal chlorosis (yellow between green veins) appears on older leaves first.",
            tags: ["nutrients", "deficiency", "GH", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q004", lessonID: "L01", difficulty: .expert,
            question: "Why do competition aquascapers target KH 2–4 dKH rather than higher values?",
            options: [
                "Low KH makes plants grow faster",
                "Low KH allows adequate CO₂ saturation without extreme injection rates",
                "High KH causes Seiryu stone to dissolve",
                "Low KH prevents calcium buildup on diffusers"
            ],
            correctIndex: 1,
            explanation: "The pH-CO₂-KH triangle means lower KH allows lower pH at lower CO₂ injection rates. High KH 'buffers against' CO₂'s acidifying effect, requiring far more injection to achieve the same dissolved CO₂ level.",
            tags: ["water chemistry", "CO2", "KH", "expert"]
        ),

        // MARK: CO₂ (L02)
        CompetitiveQuestion(
            id: "Q005", lessonID: "L02", difficulty: .beginner,
            question: "What color should a drop checker be for optimal planted tank CO₂ levels?",
            options: ["Blue", "Green", "Yellow-green", "Yellow"],
            correctIndex: 2,
            explanation: "Yellow-green indicates approximately 30 mg/L CO₂ — the optimal range for planted competition tanks. Blue = too low, yellow = potentially too high for fish.",
            tags: ["CO2", "drop checker", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q006", lessonID: "L02", difficulty: .intermediate,
            question: "What is the primary advantage of a dual-stage CO₂ regulator over a single-stage?",
            options: [
                "Higher maximum CO₂ output",
                "Eliminates end-of-tank dump as cylinder pressure drops",
                "Quieter operation",
                "Lower cost over time"
            ],
            correctIndex: 1,
            explanation: "Single-stage regulators experience 'end-of-tank dump' — a pressure surge when the cylinder nears empty that can flood the tank with lethal CO₂. Dual-stage regulators buffer this via two pressure reduction stages.",
            tags: ["CO2", "equipment", "regulator", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q007", lessonID: "L02", difficulty: .expert,
            question: "CO₂ deficiency (not excess) causes more algae because:",
            options: [
                "CO₂ directly kills algae spores",
                "Low CO₂ stalls photosynthesis, causing plants to release organic compounds that feed algae",
                "High CO₂ makes water too acidic for algae",
                "Algae require CO₂ to reproduce sexually"
            ],
            correctIndex: 1,
            explanation: "When CO₂ drops below threshold, photosynthesis stalls. Stressed plants release organic exudates into the water column — high-quality food for opportunistic algae, triggering explosive colonization.",
            tags: ["CO2", "algae", "expert"]
        ),

        // MARK: Composition (L03)
        CompetitiveQuestion(
            id: "Q008", lessonID: "L03", difficulty: .beginner,
            question: "In a 90cm competition tank, where does the Golden Ratio focal point fall on the horizontal axis?",
            options: ["45cm (center)", "56cm from left", "72cm from left", "30cm from left"],
            correctIndex: 1,
            explanation: "90cm × 0.618 ≈ 55.6cm — approximately 56cm from the left edge. This is the standard Golden Ratio focal point placement for main hardscape in a 90P tank.",
            tags: ["composition", "golden ratio", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q009", lessonID: "L03", difficulty: .intermediate,
            question: "What does the Japanese concept of shakkei (借景) mean in aquascape design?",
            options: [
                "Using only native Japanese plant species",
                "Borrowed scenery — the composition implies a world beyond the tank frame",
                "Symmetrical stone placement",
                "The use of negative space in the foreground"
            ],
            correctIndex: 1,
            explanation: "Shakkei means 'borrowed scenery' — every compositional element should suggest a larger landscape exists beyond the glass boundaries. Amano used this principle as the core goal of Nature Aquarium design.",
            tags: ["composition", "japanese aesthetics", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q010", lessonID: "L03", difficulty: .intermediate,
            question: "Why do competition aquascapers use odd numbers of stones rather than even numbers?",
            options: [
                "Even numbers are prohibited by IAPLC rules",
                "Odd numbers create asymmetric visual tension that makes the composition feel alive",
                "Even numbers are harder to source from the same batch",
                "Odd numbers reduce the total stone cost"
            ],
            correctIndex: 1,
            explanation: "From ikebana (Japanese flower arranging) — odd groupings create unresolved asymmetric tension that the eye travels between. Even groupings create balance and rest — the eye stops, the composition feels static.",
            tags: ["composition", "iwagumi", "odd numbers", "intermediate"]
        ),

        // MARK: Plants (L04)
        CompetitiveQuestion(
            id: "Q011", lessonID: "L04", difficulty: .beginner,
            question: "What pigment causes Rotala rotundifolia's red-pink coloration?",
            options: ["Chlorophyll-b", "Carotenoids", "Anthocyanins", "Phycocyanin"],
            correctIndex: 2,
            explanation: "Anthocyanin pigments produce red-pink coloration in Rotala rotundifolia — the same pigment class responsible for autumn leaf color in deciduous trees. High light + low phosphate triggers maximum anthocyanin production.",
            tags: ["plants", "rotala", "coloration", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q012", lessonID: "L04", difficulty: .intermediate,
            question: "Which carpet plant has the smallest leaf size in aquascaping?",
            options: ["Glossostigma elatinoides", "Micranthemum Monte Carlo", "Hemianthus callitrichoides Cuba", "Eleocharis parvula"],
            correctIndex: 2,
            explanation: "HC Cuba (Hemianthus callitrichoides) has leaves of just 1–2mm — the smallest of any aquatic carpet plant. This extreme fine texture creates the 'otherworldly lawn' effect seen in top IAPLC Iwagumi entries.",
            tags: ["plants", "carpet", "HC Cuba", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q013", lessonID: "L04", difficulty: .expert,
            question: "Why does Micranthemum 'Monte Carlo' appear in approximately 35% of top-50 IAPLC entries since 2015?",
            options: [
                "It was endorsed by Takashi Amano personally",
                "It combines fine texture with less demanding parameters than HC Cuba",
                "It is the only carpet plant that works in Dutch style",
                "IAPLC judges score Monte Carlo higher than other carpet species"
            ],
            correctIndex: 1,
            explanation: "Monte Carlo combines near-HC texture quality with significantly more forgiving parameters (approximately 80% of HC Cuba's demands). Introduced by Tropica in 2012, it rapidly displaced Glossostigma as the second most popular carpet species.",
            tags: ["plants", "monte carlo", "competition", "expert"]
        ),

        // MARK: Iwagumi (L05)
        CompetitiveQuestion(
            id: "Q014", lessonID: "L05", difficulty: .beginner,
            question: "What is the name of the main stone in a traditional Iwagumi arrangement?",
            options: ["Fukuishi", "Soeishi", "Oyaishi", "Suteishi"],
            correctIndex: 2,
            explanation: "Oyaishi is the main stone — the largest, most visually interesting, placed at the Golden Ratio focal point. It determines the entire visual hierarchy of the Iwagumi layout.",
            tags: ["iwagumi", "stones", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q015", lessonID: "L05", difficulty: .intermediate,
            question: "What is the Japanese concept of Ma (間) as applied to Iwagumi aquascaping?",
            options: [
                "The arrangement of stones in a triangular pattern",
                "Meaningful negative space — the open carpet between stones is compositionally active",
                "The ratio of hardscape to plant mass",
                "The use of a single carpet species across the full foreground"
            ],
            correctIndex: 1,
            explanation: "Ma is not 'empty space' but 'meaningful pause.' The carpet between Iwagumi stones is as compositionally active as the stones themselves. Aquascapes judged as 'peaceful' or 'meditative' have successfully executed Ma.",
            tags: ["iwagumi", "japanese aesthetics", "Ma", "intermediate"]
        ),

        // MARK: Dutch Style (L06)
        CompetitiveQuestion(
            id: "Q016", lessonID: "L06", difficulty: .beginner,
            question: "What is a 'Dutch street' in aquascape design?",
            options: [
                "A stone pathway through a planted layout",
                "A linear planting row of a single species running front-to-back",
                "The gap between two hardscape elements",
                "A technique for trimming stem plants in parallel rows"
            ],
            correctIndex: 1,
            explanation: "A Dutch street (straat) is a linear planting row of a single species running front-to-back through the layout, creating the illusion of a garden corridor. Classic Dutch layouts contain 2–4 streets with contrasting species.",
            tags: ["dutch style", "composition", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q017", lessonID: "L06", difficulty: .expert,
            question: "Dutch competition judges score 'craftsmanship' as the highest-weighted category. What does this primarily evaluate?",
            options: [
                "Species diversity and rarity",
                "Clean plant edges, zero algae, trimmed interfaces, perfect water clarity",
                "Color temperature and emotional impact",
                "Number of distinct Dutch streets present"
            ],
            correctIndex: 1,
            explanation: "Dutch craftsmanship scoring evaluates technical execution quality above aesthetic vision — clean plant boundaries, pristine maintenance, zero algae. The aesthetic vision is secondary. Competition aquascapers dedicate approximately 40% of total setup time to trimming precision and maintenance.",
            tags: ["dutch style", "judging", "expert"]
        ),

        // MARK: Lighting (L07)
        CompetitiveQuestion(
            id: "Q018", lessonID: "L07", difficulty: .intermediate,
            question: "What PAR level at substrate is required for demanding carpet species like HC Cuba?",
            options: ["20–40 µmol/m²/s", "40–60 µmol/m²/s", "80–120 µmol/m²/s", "150–200 µmol/m²/s"],
            correctIndex: 2,
            explanation: "HC Cuba and Glossostigma require 80–120 µmol/m²/s PAR at substrate level. Below 80, carpet plants etiolate (stretch toward light) rather than spreading laterally, resulting in a patchy, uneven carpet.",
            tags: ["lighting", "PAR", "HC Cuba", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q019", lessonID: "L07", difficulty: .expert,
            question: "What is the 'siesta' lighting schedule and what is its proposed benefit?",
            options: [
                "Lights off for 30 minutes at midday to reduce heat",
                "5 hours on → 2 hours off → 3 hours on, allowing CO₂ to recover between sessions",
                "A reduced photoperiod used only in the first 4 weeks",
                "Running lights at 50% intensity during the middle hours"
            ],
            correctIndex: 1,
            explanation: "The siesta schedule (5h on / 2h off / 3h on) allows CO₂ depleted during the morning session to recover during the off period. Plants resume the afternoon session with full CO₂ availability. Used by several top-20 IAPLC aquascapers.",
            tags: ["lighting", "photoperiod", "siesta", "expert"]
        ),

        // MARK: Fertilization (L08)
        CompetitiveQuestion(
            id: "Q020", lessonID: "L08", difficulty: .beginner,
            question: "What is the core principle of Tom Barr's Estimative Index (EI) fertilization method?",
            options: [
                "Dose the minimum nutrients plants need to prevent deficiency",
                "Dose more nutrients than plants can consume, reset weekly with water changes",
                "Match fertilizer doses to measured plant uptake rates",
                "Use only natural substrate without liquid fertilizers"
            ],
            correctIndex: 1,
            explanation: "EI doses macronutrients in surplus — more than plants consume. The weekly 50% water change resets any buildup. The key insight: algae cannot exploit nutrient surplus without the trigger of CO₂ deficiency or light excess.",
            tags: ["fertilization", "EI", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q021", lessonID: "L08", difficulty: .intermediate,
            question: "Why is phosphate (PO₄) not actually an algae driver in a balanced CO₂-injected planted tank?",
            options: [
                "Phosphate is fully absorbed by substrate before reaching algae",
                "Research shows high PO₄ does not cause algae in the presence of adequate CO₂ and balanced nutrients",
                "Algae require phosphate levels above 5 ppm to grow",
                "Phosphate acidifies water, inhibiting algae growth"
            ],
            correctIndex: 1,
            explanation: "The phosphate-algae myth came from outdoor lake eutrophication studies — irrelevant to CO₂-injected tanks. Tom Barr's EI experiments demonstrated high PO₄ in a balanced system causes zero algae. Phosphate-starved plants are MORE algae-prone due to cellular stress.",
            tags: ["fertilization", "phosphate", "algae myth", "intermediate"]
        ),

        // MARK: Algae (L09)
        CompetitiveQuestion(
            id: "Q022", lessonID: "L09", difficulty: .beginner,
            question: "What is the correct strategy when green dust algae (GDA) appears on the front glass?",
            options: [
                "Immediately wipe the glass with a magnetic cleaner",
                "Do a 50% water change and add algaecide",
                "Do NOT wipe — identify root cause, wait for the 3–4 week lifecycle to complete",
                "Add Otocinclus catfish immediately"
            ],
            correctIndex: 2,
            explanation: "GDA has a fixed 3–4 week lifecycle. Wiping glass releases spores and restarts the cycle. The correct approach: identify root cause (CO₂ instability, excess light), fix it, and let the bloom complete its lifecycle naturally before a single final cleaning.",
            tags: ["algae", "GDA", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q023", lessonID: "L09", difficulty: .intermediate,
            question: "Black Beard Algae (BBA) is definitively caused by:",
            options: [
                "Excess phosphate",
                "CO₂ fluctuation (inconsistency, not just low levels)",
                "Insufficient water changes",
                "Overstocking fish"
            ],
            correctIndex: 1,
            explanation: "BBA is caused by CO₂ fluctuation — not deficiency, but inconsistency. A tank with stable 20 mg/L CO₂ will not develop BBA. A tank fluctuating between 10 and 35 mg/L will be covered within weeks. Check solenoid schedule and diffuser cleanliness first.",
            tags: ["algae", "BBA", "CO2", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q024", lessonID: "L09", difficulty: .expert,
            question: "Why can't nitrogen deprivation eliminate cyanobacteria (BGA) from planted tanks?",
            options: [
                "BGA doesn't require nitrogen to grow",
                "BGA fixes atmospheric N₂ gas into bioavailable ammonia independently",
                "Nitrogen deprivation triggers faster BGA reproduction",
                "BGA absorbs nitrogen directly from substrate"
            ],
            correctIndex: 1,
            explanation: "Cyanobacteria are nitrogen-fixers — they convert dissolved N₂ gas into ammonia independently of water column nitrate. This makes them uniquely resistant to nitrogen starvation as a control strategy. Flow increase and mechanical removal are effective; nutrient reduction is not.",
            tags: ["algae", "BGA", "cyanobacteria", "expert"]
        ),

        // MARK: Photography (L10)
        CompetitiveQuestion(
            id: "Q025", lessonID: "L10", difficulty: .intermediate,
            question: "Why should fish be removed from the tank during competition photography?",
            options: [
                "Fish disturb the carpet plants during the session",
                "Fish create motion blur and their positions are uncontrollable",
                "IAPLC rules prohibit fish in competition entries",
                "Fish consume the oxygen pearling bubbles"
            ],
            correctIndex: 1,
            explanation: "At the shutter speeds required for aquascape photography (below 1/100s in low-light tank conditions), fish movement creates motion blur. Their positions are also unpredictable — a fish in front of the focal stone can ruin an otherwise perfect frame. ~60% of top-50 IAPLC entries show no fish.",
            tags: ["photography", "competition", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q026", lessonID: "L10", difficulty: .expert,
            question: "When is the optimal 'one-hour window' for competition aquascape photography?",
            options: [
                "Immediately after lights turn on",
                "90–120 minutes into the photoperiod when CO₂ saturation peaks and pearling is active",
                "During the last 30 minutes before lights off",
                "Exactly at the midpoint of the photoperiod"
            ],
            correctIndex: 1,
            explanation: "90–120 minutes after CO₂ reaches full saturation during the photoperiod, plants are actively pearling, colors are most vivid, and water clarity is maximum. This window cannot be extended indefinitely — schedule the photography session to align precisely with it.",
            tags: ["photography", "pearling", "expert"]
        ),

        // MARK: Filtration (L11)
        CompetitiveQuestion(
            id: "Q027", lessonID: "L11", difficulty: .beginner,
            question: "Why is activated carbon removed from competition planted tank filters?",
            options: [
                "It makes the water too alkaline",
                "It adsorbs chelated iron and trace element supplements within 24–48 hours",
                "It reduces CO₂ dissolving efficiency",
                "It promotes BBA growth"
            ],
            correctIndex: 1,
            explanation: "Activated carbon adsorbs EDTA-chelated iron and trace elements from the water column, creating trace mineral deficiencies within 24–48 hours of replacement. It is removed at setup and never reintroduced during the growing period.",
            tags: ["filtration", "activated carbon", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q028", lessonID: "L11", difficulty: .intermediate,
            question: "What is the minimum filter turnover rate competition aquascapers target for a 180L tank?",
            options: ["5× per hour (900 L/h)", "8–12× per hour (1,440–2,160 L/h)", "3× per hour (540 L/h)", "15× per hour (2,700 L/h)"],
            correctIndex: 1,
            explanation: "Competition standard is 8–12× tank volume turnover per hour. Higher flow delivers CO₂ and nutrients to plant surfaces faster, removes organic waste before settlement, and maintains uniform water chemistry throughout the column.",
            tags: ["filtration", "flow rate", "intermediate"]
        ),

        // MARK: Timeline (L12)
        CompetitiveQuestion(
            id: "Q029", lessonID: "L12", difficulty: .intermediate,
            question: "In the 16-week competition timeline, when should the first major stem plant trim occur?",
            options: ["Week 2–3", "Week 5–6 (cut to 50%, replant tops)", "Week 9–10", "Week 13–14"],
            correctIndex: 1,
            explanation: "The first major trim at weeks 5–6 cuts stems to 50% height and replants tops. The original base resprouts + replanted top each grow, doubling density. Done three times over 6 weeks, one stem becomes eight — creating competition-grade mass planting density.",
            tags: ["timeline", "trimming", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q030", lessonID: "L12", difficulty: .expert,
            question: "Why is the compositional decision in Week 1 called 'irreversible' in competition aquascaping?",
            options: [
                "IAPLC rules prohibit changing composition after submission",
                "Every subsequent week builds on that structural foundation — flawed structure cannot be compensated by plant quality or photography",
                "Substrate cannot be repositioned after water is added",
                "Hardscape stones crack if moved after the tank fills"
            ],
            correctIndex: 1,
            explanation: "The Irreversibility Principle: every week of growth builds on the compositional structure decided in Week 1. A structurally flawed composition cannot be rescued by perfect plants, water chemistry, or photography. The Week 1 decision deserves disproportionate time and precision.",
            tags: ["timeline", "composition", "expert"]
        ),

        // MARK: General / Fact-based
        CompetitiveQuestion(
            id: "Q031", lessonID: nil, difficulty: .beginner,
            question: "In what year did the IAPLC (International Aquatic Plants Layout Contest) begin?",
            options: ["1994", "1998", "2001", "2005"],
            correctIndex: 2,
            explanation: "The IAPLC began in 2001 with just 89 entries from Japan. By 2019 it received over 2,700 entries from 73 countries, becoming the largest aquascaping competition in the world.",
            tags: ["history", "IAPLC", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q032", lessonID: nil, difficulty: .intermediate,
            question: "ADA (Aqua Design Amano) was originally founded as what type of company?",
            options: ["Aquarium equipment manufacturer", "Nature photography company", "Botanical research institute", "Fish breeding facility"],
            correctIndex: 1,
            explanation: "ADA was founded in 1985 as a nature photography company. The aquarium division grew from Amano's need for photogenic tank backgrounds for his fish photography — the entry into aquascaping equipment was essentially accidental.",
            tags: ["history", "ADA", "Amano", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q033", lessonID: nil, difficulty: .expert,
            question: "Which country set the record for most IAPLC entries submitted in a single year?",
            options: ["Japan", "USA", "Germany", "Brazil"],
            correctIndex: 3,
            explanation: "Brazil holds the record with 412 entries in 2018, reflecting the explosive growth of planted aquarium culture in South America — particularly in São Paulo's competitive aquascaping community.",
            tags: ["history", "IAPLC", "Brazil", "expert"]
        ),

        // MARK: Substrate (L01-related)
        CompetitiveQuestion(
            id: "Q034", lessonID: "L01", difficulty: .beginner,
            question: "Why is ADA Aqua Soil Amazonia considered an 'active' substrate?",
            options: ["It contains iron beads that activate plant roots", "It releases ammonia and acidifies water, requiring a fishless cycle", "It charges with electricity from the filter pump", "It contains live bacteria added at the factory"],
            correctIndex: 1,
            explanation: "Active substrates like Amazonia release ammonium and lower pH during the initial cycle — creating a fishless cycling period of 3–4 weeks. This ammonia spike is actually beneficial: it seeds the nitrogen cycle and feeds the first bacteria colonies.",
            tags: ["substrate", "amazonia", "cycling", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q035", lessonID: "L01", difficulty: .intermediate,
            question: "What is the recommended substrate depth for a high-tech planted competition tank?",
            options: ["1–2 cm (cost-saving thin layer)", "3–4 cm (minimum for root development)", "6–8 cm with sloped foreground", "10+ cm to maximize nutrient storage"],
            correctIndex: 2,
            explanation: "6–8 cm depth (sloped higher toward the back) creates essential depth illusion in photographs and provides sufficient root zone. Many top aquascapers use a base layer of coarse material with 4–5 cm Amazonia on top — total depth 6–9 cm at the back wall.",
            tags: ["substrate", "depth", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q036", lessonID: "L01", difficulty: .expert,
            question: "When remineralizing RO water for competition tanks, which ratio of Mg to Ca is considered optimal for planted tank growth?",
            options: ["1:1 (equal parts)", "1:3 (Mg:Ca)", "1:4 (Mg:Ca)", "3:1 (Mg:Ca)"],
            correctIndex: 1,
            explanation: "A 1:3 Mg:Ca ratio closely mirrors the ionic balance in soft Amazonian water where many popular competition plants originate. Excess calcium without sufficient magnesium inhibits magnesium uptake — a common deficiency in tanks built on tap water with naturally high Ca:Mg imbalance.",
            tags: ["water chemistry", "RO water", "remineralization", "expert"]
        ),

        // MARK: Hardscape
        CompetitiveQuestion(
            id: "Q037", lessonID: "L05", difficulty: .beginner,
            question: "Which type of stone raises GH and KH significantly and should be avoided in low-KH setups?",
            options: ["Ohko (Dragon) Stone", "Seiryu Stone", "Manten Stone", "Elephant Skin Stone"],
            correctIndex: 1,
            explanation: "Seiryu stone is limestone-based and continuously leaches calcium carbonate into the water, raising KH and GH over time. In a CO₂-injected competition tank targeting KH 2–4 dKH, Seiryu stone can push KH above 8 within weeks — negating the low-KH strategy entirely.",
            tags: ["hardscape", "seiryu stone", "KH", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q038", lessonID: "L05", difficulty: .intermediate,
            question: "What is the visual principle behind burying 30–40% of each stone's base into the substrate?",
            options: ["It prevents stones from falling over", "It creates the illusion the stones are geological formations emerging from deep underground", "It reduces KH leaching from limestone stones", "It creates better root attachment surfaces"],
            correctIndex: 1,
            explanation: "Partially burying stones mimics natural geology — rocks in nature are not placed on surfaces but emerge from them. The visual weight of buried stones grounds the composition and makes it feel geologically inevitable rather than 'placed.' Amano called this principle 'the stone remembers the earth.'",
            tags: ["hardscape", "iwagumi", "composition", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q039", lessonID: "L05", difficulty: .expert,
            question: "Why do competition aquascapers source all stones from the same geological batch rather than mixing quarries?",
            options: ["Mixed quarries have inconsistent KH impact", "Same-batch stones share identical mineral veining, texture lines, and weathering patterns — different batches create visual discontinuity", "Quarry mixing is prohibited by IAPLC rules", "Mixed stones have inconsistent density affecting stability"],
            correctIndex: 1,
            explanation: "The compositional goal is for all stones to appear as one geological formation. Same-batch stones share identical grain direction, texture rhythm, and color temperature. Mixed batches — even of the same stone type — create subtle visual discontinuities that judges read as 'assembled' rather than 'discovered.'",
            tags: ["hardscape", "sourcing", "composition", "expert"]
        ),

        // MARK: Mosses & Epiphytes
        CompetitiveQuestion(
            id: "Q040", lessonID: "L04", difficulty: .beginner,
            question: "What is the correct attachment method for Anubias to driftwood in a competition setup?",
            options: ["Plant the rhizome deep into substrate", "Tie with fishing line or thread — never bury the rhizome", "Use super glue gel to bond directly to hardscape", "Anchor with rubber bands for the first 6 weeks"],
            correctIndex: 1,
            explanation: "Anubias attaches via rhizome — burying the rhizome causes rot. Fine fishing line (or biodegradable cotton thread) holds it against hardscape until the roots self-anchor over 3–5 weeks. Super glue gel (cyanoacrylate) is also used in competition settings when speed matters.",
            tags: ["plants", "anubias", "attachment", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q041", lessonID: "L04", difficulty: .intermediate,
            question: "Taiwan moss (Taxiphyllum alternans) is preferred over Java moss in competition setups because:",
            options: ["It grows faster than Java moss", "Its triangular frond structure creates a finer, more geometric texture with less tangling", "It thrives in warmer temperatures than Java moss", "It requires zero CO₂ while Java moss needs injection"],
            correctIndex: 1,
            explanation: "Taiwan moss grows in precise triangular patterns that stack geometrically — creating a 'layered scale' texture highly valued in competition photography. Java moss grows more randomly and tangles easily. At the same tank parameters, Taiwan moss photographs 60–70% better in macro shots due to this structural regularity.",
            tags: ["plants", "moss", "texture", "intermediate"]
        ),

        // MARK: Fish Selection
        CompetitiveQuestion(
            id: "Q042", lessonID: "L12", difficulty: .beginner,
            question: "Which fish species is most commonly found in IAPLC Grand Prize winning Nature Aquarium entries?",
            options: ["Cardinal Tetra (Paracheirodon axelrodi)", "Rummy-nose Tetra (Hemigrammus rhodostomus)", "Otocinclus affinis", "Neon Tetra (Paracheirodon innesi)"],
            correctIndex: 0,
            explanation: "Cardinal tetras appear in approximately 45% of top-10 IAPLC Nature Aquarium entries. Their intensely blue horizontal stripe and deep red lower body contrast dramatically against green carpets, and schooling behavior in groups of 20+ creates the 'river of light' effect valued in competition photography.",
            tags: ["fish", "cardinal tetra", "IAPLC", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q043", lessonID: "L11", difficulty: .intermediate,
            question: "Why are Otocinclus catfish preferred over Siamese Algae Eaters (SAE) in competition planted tanks?",
            options: ["Otocinclus eat more algae per day", "Otocinclus remain small and photogenic; SAEs grow large, become aggressive, and eat soft plants at maturity", "SAEs require higher temperatures incompatible with planted tanks", "Otocinclus are less expensive to source"],
            correctIndex: 1,
            explanation: "Juvenile SAEs effectively eat hair algae and BBA, but adults (8–12 cm) become territorial, damage delicate stem plants, and often stop eating algae in favor of easier food. Otocinclus stay under 4 cm their entire life and focus on biofilm and diatoms without plant damage.",
            tags: ["fish", "algae eaters", "maintenance", "intermediate"]
        ),

        // MARK: IAPLC History & Rules
        CompetitiveQuestion(
            id: "Q044", lessonID: nil, difficulty: .beginner,
            question: "What is the maximum tank volume allowed in the IAPLC Grand Prix category?",
            options: ["60L", "200L", "No maximum — any size is permitted", "500L"],
            correctIndex: 2,
            explanation: "IAPLC has no maximum tank volume restriction — entries have ranged from nano tanks (under 30L) to 1,500L displays. However, judging criteria favor visual depth and compositional complexity, which naturally disadvantages very small tanks against well-executed large layouts in scoring.",
            tags: ["IAPLC", "rules", "competition", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q045", lessonID: nil, difficulty: .intermediate,
            question: "Which aquascape style is explicitly NOT eligible for IAPLC competition?",
            options: ["Dutch style", "Nature Aquarium style", "Biotope aquarium (exact habitat replica)", "Jungle style"],
            correctIndex: 2,
            explanation: "Biotope aquascapes — exact replicas of specific natural habitats with species-accurate plants, fish, and hardscape — are judged in separate competitions (BAP, BAPS). IAPLC focuses on artistic interpretation of nature, not scientific replication. Biotope entries are often disqualified from IAPLC judging.",
            tags: ["IAPLC", "biotope", "style", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q046", lessonID: nil, difficulty: .expert,
            question: "Takashi Amano won the IAPLC Grand Prize how many times before his death in 2015?",
            options: ["Never — as the founder, he was ineligible to compete", "3 times", "7 times", "He won every year from 2001–2010"],
            correctIndex: 0,
            explanation: "Amano created the IAPLC as a platform for others, not himself. As founder and primary judge, he never entered a personal submission into the competition. His Grand Prix winner selections are published in annual ADA catalogs and his own photographic books — these became the de facto judging standard.",
            tags: ["IAPLC", "Amano", "history", "expert"]
        ),

        // MARK: Water Changes & Maintenance
        CompetitiveQuestion(
            id: "Q047", lessonID: "L11", difficulty: .beginner,
            question: "What water change schedule do most competition aquascapers follow during active growth phase?",
            options: ["10% monthly", "20% every two weeks", "50% weekly", "100% bi-weekly reset"],
            correctIndex: 2,
            explanation: "50% weekly water changes are standard for competition tanks using EI fertilization. Weekly changes reset nutrient accumulation, dilute organic waste, refresh CO₂ capacity, and provide a consistent physiological reset that plants and bacteria benefit from. Reduced changes cause TDS creep and water quality decline.",
            tags: ["maintenance", "water change", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q048", lessonID: "L11", difficulty: .intermediate,
            question: "At what TDS level should a competition aquascaper start investigating water quality decline?",
            options: ["Above 100 ppm", "Above 200 ppm", "Above 400 ppm", "TDS is irrelevant in planted tanks"],
            correctIndex: 2,
            explanation: "In RO-based setups targeting GH 4–6, TDS should sit around 150–250 ppm from mineral additions alone. When TDS exceeds 400 ppm without deliberate fertilizer additions, organic waste accumulation and salt creep are indicated. Investigation of water change frequency and evaporation replacement practices is warranted.",
            tags: ["maintenance", "TDS", "water quality", "intermediate"]
        ),

        // MARK: Photography & Presentation
        CompetitiveQuestion(
            id: "Q049", lessonID: "L10", difficulty: .beginner,
            question: "What camera setting prevents the 'green cast' common in aquascape photography under LED lighting?",
            options: ["Increase ISO above 3200", "Set white balance manually to the specific LED's Kelvin temperature", "Use automatic white balance (AWB)", "Apply a UV filter to the lens"],
            correctIndex: 1,
            explanation: "LEDs have complex spectral peaks that confuse AWB algorithms, producing green or magenta casts. Manual white balance calibrated precisely to the LED's Kelvin output (typically 6,500–8,000K for planted tank LEDs) eliminates the cast entirely. Most professional aquascape photographers shoot in RAW for post-processing control.",
            tags: ["photography", "white balance", "LED", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q050", lessonID: "L10", difficulty: .expert,
            question: "What aperture range produces the sharpest foreground-to-background clarity in a 90cm aquascape shot from 1 meter distance?",
            options: ["f/1.4–f/2.8 for maximum light gathering", "f/8–f/11 for maximum depth of field", "f/16–f/22 for diffraction-limited sharpness", "Aperture is irrelevant — use focus stacking only"],
            correctIndex: 1,
            explanation: "f/8–f/11 is the 'sweet spot' for most camera lenses — beyond f/11 diffraction softens the image. At 1 meter shooting distance with a standard focal length, f/8 captures a 90cm tank front-to-back with sufficient sharpness. Use a tripod and remote shutter at these apertures to eliminate camera shake at the longer exposure times required.",
            tags: ["photography", "aperture", "depth of field", "expert"]
        ),

        // MARK: CO₂ Advanced
        CompetitiveQuestion(
            id: "Q051", lessonID: "L02", difficulty: .intermediate,
            question: "An inline CO₂ reactor placed on the filter output is preferred over a glass diffuser because:",
            options: ["It produces larger CO₂ bubbles that dissolve faster", "It achieves near-100% dissolution with zero surface microbubbles disrupting the aesthetic", "It costs less than glass diffusers over 12 months", "It operates silently unlike glass diffuser clicking"],
            correctIndex: 1,
            explanation: "Inline reactors dissolve CO₂ completely inside the reactor chamber before water returns to the tank — zero micro-bubble contamination of the water column. Glass diffusers release visible micro-bubbles that scatter in photographs. For competition photography, inline reactors are standard: photographers cannot distinguish 'good' micro-bubbles from 'algae pearling' in post-processing.",
            tags: ["CO2", "inline reactor", "equipment", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q052", lessonID: "L02", difficulty: .expert,
            question: "CO₂ injection should begin how long before lights turn on in a competition tank?",
            options: ["Simultaneously with lights", "30–60 minutes before lights", "2 hours before lights", "CO₂ runs 24 hours continuously"],
            correctIndex: 1,
            explanation: "CO₂ takes 30–60 minutes to reach target saturation levels after the solenoid opens. Starting injection simultaneously with lights means plants begin photosynthesis with inadequate CO₂ — triggering the stress response that feeds algae. The 30–60 minute head start ensures CO₂ is at competition concentration when the first photon hits the leaves.",
            tags: ["CO2", "timing", "solenoid", "expert"]
        ),

        // MARK: Nitrogen Cycle Advanced
        CompetitiveQuestion(
            id: "Q053", lessonID: "L01", difficulty: .intermediate,
            question: "Why do heavily planted competition tanks often show zero nitrate (NO₃) despite regular feeding?",
            options: ["Denitrifying bacteria in the substrate remove all nitrate", "The plant biomass consumes nitrate faster than fish waste produces it", "Activated carbon in the filter removes nitrate", "Nitrate evaporates from the water surface"],
            correctIndex: 1,
            explanation: "A densely planted competition tank (high plant-to-fish ratio) has plants consuming nitrate as nitrogen for growth faster than fish produce it. This is the desired 'plant-driven' tank state. When nitrate reads zero and plants are healthy, it indicates the system is perfectly balanced — not nutrient-poor.",
            tags: ["nitrogen cycle", "nitrate", "planted tank balance", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q054", lessonID: "L01", difficulty: .expert,
            question: "Which plant nutrient cannot be removed from the water column once added, making overdosing especially dangerous?",
            options: ["Nitrate (NO₃)", "Phosphate (PO₄)", "Iron (Fe)", "Copper (Cu)"],
            correctIndex: 3,
            explanation: "Copper (Cu) accumulates in substrate and biofilm permanently and has no safe dilution pathway once integrated into organic matter. Fish and invertebrates are extremely sensitive — shrimp die at 0.02 ppm. Many liquid fertilizers contain trace copper; overdosing 'comprehensive' traces can crash an invertebrate population within hours.",
            tags: ["nutrients", "copper toxicity", "expert"]
        ),

        // MARK: Style & Aesthetics
        CompetitiveQuestion(
            id: "Q055", lessonID: "L03", difficulty: .intermediate,
            question: "The 'jungle style' aquascape differs from Nature Aquarium style primarily in:",
            options: ["It uses exclusively South American plant species", "It intentionally abandons compositional rules in favor of overgrown natural density without visible hardscape dominance", "It requires no CO₂ injection", "It mimics mangrove environments specifically"],
            correctIndex: 1,
            explanation: "Jungle style (Filipe Oliveira, Serkan Çetinkol) deliberately abandons the controlled minimalism of Nature Aquarium. The goal is overwhelming botanical abundance — plants overflow, intertwine, and obscure hardscape. Paradoxically, it requires MORE technical skill: photosynthesis must be precisely balanced across dozens of overlapping species.",
            tags: ["style", "jungle style", "composition", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q056", lessonID: "L03", difficulty: .expert,
            question: "In the ADA 'Nature Aquarium' aesthetic philosophy, what does 'wabi-sabi' contribute to aquascape design?",
            options: ["Mathematical precision and symmetrical balance", "Acceptance of imperfection and transience — plants will grow, compositions will change", "The use of natural materials over artificial ones", "Strict species authenticity to a single geographic region"],
            correctIndex: 1,
            explanation: "Wabi-sabi (侘寂) embraces imperfection and impermanence as the source of beauty. In aquascaping: the moss that attaches unevenly, the slight lean of a stone, the way growth changes the composition weekly. Amano wrote that 'a perfectly controlled aquascape denies the river its voice.' This philosophy separates Nature Aquarium from engineered Dutch style.",
            tags: ["aesthetics", "wabi-sabi", "Japanese philosophy", "expert"]
        ),

        // MARK: Pearling & Plant Health
        CompetitiveQuestion(
            id: "Q057", lessonID: "L02", difficulty: .beginner,
            question: "What causes plants to 'pearl' (release visible oxygen bubbles) during photosynthesis?",
            options: ["Excess CO₂ being expelled from the leaf", "Oxygen production exceeding the leaf's capacity to dissolve into surrounding water — excess forms bubbles", "Nitrogen gas released during nutrient uptake", "Water movement past leaf surfaces creating cavitation bubbles"],
            correctIndex: 1,
            explanation: "Pearling occurs when photosynthesis is so active that oxygen production outpaces dissolution into surrounding water — the excess forms visible bubbles on leaf surfaces before rising. Heavy pearling indicates CO₂ is abundant, light is sufficient, and nutrients are available: the 'green light' of competition readiness.",
            tags: ["plants", "pearling", "photosynthesis", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q058", lessonID: "L04", difficulty: .intermediate,
            question: "Rotala macrandra 'Japan' produces deep magenta color reliably only under which conditions?",
            options: ["High nitrate (30+ ppm) and high phosphate", "High light (80+ PAR), low nitrate (<5 ppm), low phosphate (<0.5 ppm), and intense iron dosing", "Cool temperatures (18–20°C) and alkaline pH", "Daily dosing with liquid carbon (glutaraldehyde)"],
            correctIndex: 1,
            explanation: "Rotala macrandra 'Japan' is the most demanding red stem plant in competition use. Maximum anthocyanin expression requires: high PAR (the limiting factor most aquascapers miss), deliberately starved nitrogen and phosphate (stress-induced pigmentation), and supplemental iron at 2–3× normal dosing. Without all three, it grows green.",
            tags: ["plants", "rotala macrandra", "coloration", "intermediate"]
        ),

        // MARK: Competition Strategy
        CompetitiveQuestion(
            id: "Q059", lessonID: "L12", difficulty: .intermediate,
            question: "What is the '16-week rule' followed by most serious IAPLC competitors?",
            options: ["All plants must be sourced 16 weeks before the submission deadline", "The tank is set up exactly 16 weeks before the photography window to reach peak visual maturity", "A minimum of 16 species must be present in the submission", "The aquascape must be maintained for 16 continuous weeks without any plant changes"],
            correctIndex: 1,
            explanation: "Peak competition condition requires: 4 weeks cycling + 4 weeks initial growth + 4 weeks density building via trimming + 4 weeks final refinement. This 16-week arc brings all elements — carpet density, stem plant mass, moss coverage, water clarity — to simultaneous peak. Rushed entries photographed at 8–10 weeks consistently score 15–20% lower.",
            tags: ["competition", "timeline", "strategy", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q060", lessonID: "L12", difficulty: .expert,
            question: "Which single factor most commonly separates IAPLC top-10 entries from top-100 entries, according to judges' published commentary?",
            options: ["Species rarity and uniqueness of plant selection", "Compositional coherence — every element serves the single central visual idea", "Water chemistry perfection as measured by test results", "Tank size (larger tanks score proportionally higher)"],
            correctIndex: 1,
            explanation: "IAPLC judges consistently cite 'coherence of expression' as the differentiator. Top-10 entries pursue a single, clear visual idea (a mountain, a forest, a stream) with zero extraneous elements. Top-100 entries often show technical excellence but with competing visual stories — a stunning moss wall that distracts from the stone composition, beautiful red stems that break the color harmony.",
            tags: ["IAPLC", "judging", "composition", "expert"]
        ),
        CompetitiveQuestion(
            id: "Q061", lessonID: nil, difficulty: .intermediate,
            question: "The AGA (Aquatic Gardeners Association) competition differs from IAPLC in which major way?",
            options: ["AGA uses live judges present at the tank; IAPLC uses photographs only", "AGA prohibits the use of CO₂ injection", "AGA judges photographs but has separate scoring categories for Dutch, Nature, and Biotope styles", "IAPLC allows digital editing of submitted photos; AGA does not"],
            correctIndex: 2,
            explanation: "AGA separates entries into defined style categories (Nature, Dutch, Biotope, Paludarium, etc.) with style-appropriate judging criteria. IAPLC uses a single universal scoresheet. This means a Dutch-style entry in AGA is judged by Dutch experts against Dutch criteria — a fundamentally different competitive environment than IAPLC's style-neutral approach.",
            tags: ["AGA", "competition", "style categories", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q062", lessonID: nil, difficulty: .expert,
            question: "Which aquascaper holds the record for most consecutive top-10 IAPLC placements?",
            options: ["Takayuki Fukada", "Serkan Çetinkol", "Filipe Oliveira", "Viktor Lantos"],
            correctIndex: 0,
            explanation: "Takayuki Fukada (Japan) achieved nine consecutive top-10 IAPLC placements from 2009–2017 — an unbroken record. His Nature Aquarium compositions are studied globally for their mastery of scale illusion: his tanks appear to contain actual mountain landscapes. He won Grand Prix in 2013 with 'Burning Hill.'",
            tags: ["IAPLC", "Fukada", "history", "expert"]
        ),
        CompetitiveQuestion(
            id: "Q063", lessonID: "L09", difficulty: .intermediate,
            question: "Hair algae (Spirogyra) is uniquely difficult to remove because:",
            options: ["It grows 3× faster than other algae types", "It wraps around plant stems cell-by-cell and cannot be physically removed without damaging the host plant", "It produces toxins that inhibit algaecide effectiveness", "It reproduces through the filter media, re-seeding the tank after each removal"],
            correctIndex: 1,
            explanation: "Spirogyra filaments physically entwine around plant cells. Mechanical removal tears plant tissue — each removal attempt spreads fragments that re-anchor. The only effective strategy: maximize plant health (CO₂, nutrients, light balance) so plant growth outcompetes the algae, and introduce manual removal ONLY with long tweezers in a twisting motion to capture without fragmenting.",
            tags: ["algae", "hair algae", "spirogyra", "intermediate"]
        ),

        // MARK: Driftwood & Preparation
        CompetitiveQuestion(
            id: "Q064", lessonID: "L05", difficulty: .beginner,
            question: "Why is driftwood boiled before being placed in a competition tank?",
            options: ["To sterilize bacteria that could harm fish", "To leach tannins faster and waterlog the wood so it sinks without weights", "To expand the wood fibers for better moss attachment", "To remove calcium deposits from the wood surface"],
            correctIndex: 1,
            explanation: "Boiling accelerates tannin release (a process that would otherwise take months in-tank) and forces water into the wood's cellular structure, eliminating buoyancy. For competition tanks where tannin staining is undesirable, 4–6 rounds of boiling and soaking in fresh water removes 80–90% of color compounds before planting.",
            tags: ["hardscape", "driftwood", "preparation", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q065", lessonID: "L05", difficulty: .intermediate,
            question: "Spiderwood (Azalea root) is favored in 'forest style' aquascapes over conventional driftwood because:",
            options: ["It never releases tannins into the water", "Its branching structure mimics tree canopies, creating naturalistic overhead compositions", "It is inert and does not affect pH or KH", "It provides better surface area for filter bacteria"],
            correctIndex: 1,
            explanation: "Azalea root's fine, multi-directional branching replicates aerial root structures of banyan and mangrove trees. When arranged vertically with downward-arching branches, it creates a canopy illusion that adds the critical 'above' dimension missing from horizontal stone layouts. Paired with Anubias and Bucephalandra epiphytes, it produces the forest interior effect.",
            tags: ["hardscape", "driftwood", "forest style", "intermediate"]
        ),

        // MARK: Tools & Technique
        CompetitiveQuestion(
            id: "Q066", lessonID: "L12", difficulty: .beginner,
            question: "Which scissor type is used for trimming carpet plants like HC Cuba flush to the substrate?",
            options: ["Straight scissors", "Curved scissors", "Spring scissors", "Wave-edge scissors"],
            correctIndex: 1,
            explanation: "Curved aquascaping scissors (concave blade) allow the tip to reach the carpet surface parallel to the substrate without the handle disturbing the surrounding plants. Straight scissors force an angle that either misses the base or tears neighboring plants. Most professionals use a curved + spring combination for continuous trimming sessions.",
            tags: ["tools", "trimming", "carpet plants", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q067", lessonID: "L12", difficulty: .intermediate,
            question: "What is the 'push-and-pull' planting technique for delicate stem plants?",
            options: ["Planting with alternating forward and backward motions to compact the substrate", "Using tweezers to push the stem down, then releasing and withdrawing upward while the substrate grips the stem", "A two-person technique for planting large bunches simultaneously", "Rotating the tweezers 90° while inserting to create a pilot hole"],
            correctIndex: 1,
            explanation: "The push-and-pull technique: insert tweezers holding the stem at 45°, push 3–4 cm into substrate, pinch open slightly to release the stem, then withdraw upward in a single smooth motion. The substrate closes around the stem as tweezers exit. Pulling upward rather than straight back prevents extracting the plant you just planted.",
            tags: ["tools", "planting technique", "stem plants", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q068", lessonID: "L10", difficulty: .expert,
            question: "Why do competition photographers use a polarizing filter when shooting aquascapes?",
            options: ["To increase color saturation of red plants", "To eliminate reflections from the glass and water surface that create glare and distort colors", "To reduce the required shutter speed for sharper images", "To filter out the green spectrum emitted by planted tank LEDs"],
            correctIndex: 1,
            explanation: "A circular polarizing filter (CPL) eliminates glass reflections and internal light scattering that wash out mid-tone contrast in aquascape photos. Rotated at 90° to the reflection angle, it removes the 'haze' on glass and water surfaces — recovering the deep blacks in shadow areas that distinguish top-10 IAPLC photography from amateur shots.",
            tags: ["photography", "polarizing filter", "technique", "expert"]
        ),

        // MARK: Tissue Culture & Plant Adaptation
        CompetitiveQuestion(
            id: "Q069", lessonID: "L04", difficulty: .beginner,
            question: "What is the main advantage of tissue culture (TC) plants over traditionally grown plants for competition setups?",
            options: ["TC plants grow twice as fast as traditionally grown plants", "TC plants are guaranteed pest-free, snail-free, and algae-free — a clean start for competition tanks", "TC plants require less CO₂ than traditionally grown specimens", "TC plants have stronger root systems at purchase"],
            correctIndex: 1,
            explanation: "Tissue culture plants are grown in sterile laboratory conditions — zero algae spores, zero snail eggs, zero pest organisms. For a competition tank where a single hitchhiker snail or algae introduction can derail weeks of progress, TC plants eliminate a major risk vector entirely. The trade-off: TC plants require 2–3 week 'hardening' as they transition from emersed to submersed growth.",
            tags: ["plants", "tissue culture", "pest-free", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q070", lessonID: "L04", difficulty: .intermediate,
            question: "What is 'plant melt' and what causes it in newly introduced aquatic plants?",
            options: ["Leaves becoming translucent from excess iron", "The die-back of emersed-grown leaves as the plant transitions to submersed growth and regenerates with aquatic leaf structure", "Root rot caused by anaerobic substrate conditions", "Ammonia burn from active substrate leaching"],
            correctIndex: 1,
            explanation: "Most aquarium plants are commercially grown emersed (above water) for shipping efficiency. When submerged, the emersed leaves — optimized for air — cannot function underwater and die back. The plant simultaneously grows new leaves with different morphology adapted for underwater gas exchange. Melt is normal; removing decaying leaves promptly prevents ammonia spikes.",
            tags: ["plants", "plant melt", "emersed vs submersed", "intermediate"]
        ),

        // MARK: Shrimp & Invertebrates
        CompetitiveQuestion(
            id: "Q071", lessonID: "L11", difficulty: .beginner,
            question: "Amano shrimp are highly valued in planted tank maintenance because they consume which algae type that fish typically ignore?",
            options: ["Green spot algae (GSA)", "Staghorn algae and thread algae", "Blue-green algae (cyanobacteria)", "Green dust algae (GDA)"],
            correctIndex: 1,
            explanation: "Amano shrimp (Caridina multidentata) consume staghorn algae and hair thread algae with high efficiency — types largely ignored by fish and Otocinclus. A colony of 10–15 Amano shrimp in a 90cm tank provides constant maintenance of early-stage filamentous algae, preventing establishment before it becomes a serious problem.",
            tags: ["invertebrates", "amano shrimp", "algae control", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q072", lessonID: "L11", difficulty: .intermediate,
            question: "Why are Nerite snails preferred over Mystery (Apple) snails in competition planted tanks?",
            options: ["Nerites consume more algae per day than Mystery snails", "Nerites cannot reproduce in freshwater — zero population explosion risk, unlike Mystery snails which breed prolifically", "Nerites tolerate softer water chemistry than Mystery snails", "Nerites are smaller and less likely to disturb carpet planting"],
            correctIndex: 1,
            explanation: "Nerite snail eggs require brackish water to hatch — they lay eggs on glass and hardscape but never reproduce in freshwater. Mystery snails breed exponentially in freshwater, quickly becoming a maintenance burden. For a competition tank where population control is critical, Nerites are the only snail species offering consistent bioload.",
            tags: ["invertebrates", "nerite snails", "maintenance", "intermediate"]
        ),

        // MARK: Lighting Spectrum
        CompetitiveQuestion(
            id: "Q073", lessonID: "L07", difficulty: .intermediate,
            question: "What does PUR (Photosynthetically Usable Radiation) measure, and why does it matter more than PAR for planted tanks?",
            options: ["PUR measures total light output in lumens — a more accurate human eye measurement", "PUR measures only the specific wavelengths (blue 430–450nm, red 640–680nm) that chlorophyll actually absorbs — high PAR with low PUR wastes light", "PUR is the PAR reading adjusted for water depth attenuation", "PUR measures UV radiation output that protects against algae"],
            correctIndex: 1,
            explanation: "PAR counts all photons in the 400–700nm range — including green (500–580nm) which chlorophyll reflects rather than absorbs. A full-spectrum white LED may have high PAR but poor PUR if it lacks the blue and red peaks plants use. Lights optimized for PUR can achieve equivalent plant growth at lower total PAR — relevant for managing algae risk in competition tanks.",
            tags: ["lighting", "PUR", "spectrum", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q074", lessonID: "L07", difficulty: .expert,
            question: "Why do some competition aquascapers run two separate light fixtures — one warm white, one cool white — rather than a single broad-spectrum LED?",
            options: ["Dual fixtures reduce electrical cost compared to a single high-power LED", "Mixing warm and cool spectrum creates a more natural CRI, enhances red plant coloration under warm light, and allows independent dimming control for each spectrum", "Dual fixtures are required by IAPLC equipment rules", "Two fixtures prevent the 'hot spot' shadow artifact of single-point lighting"],
            correctIndex: 1,
            explanation: "Warm white LEDs (2700–4000K) enhance red anthocyanin expression in plants like Rotala macrandra. Cool white (6500K+) maximizes PAR output and blue-spectrum photosynthesis. Running both independently allows the aquascaper to dial in color rendering for photography (boost warm for reds) separately from growth optimization mode — a technique used by multiple top-10 IAPLC competitors.",
            tags: ["lighting", "dual spectrum", "LED", "expert"]
        ),

        // MARK: Tank Cycling
        CompetitiveQuestion(
            id: "Q075", lessonID: "L01", difficulty: .beginner,
            question: "What is 'dry start method' (DSM) and what is its primary benefit for planted tanks?",
            options: ["Running the filter without water for 24 hours to seed it before flooding", "Growing carpet plants emersed before flooding — they establish a dense, even carpet in 4–6 weeks with no CO₂ equipment required", "Letting the substrate dry fully between water changes to prevent anaerobic zones", "A fishless cycle using dry ammonia powder instead of liquid ammonia"],
            correctIndex: 1,
            explanation: "DSM involves planting carpet species in moist substrate, sealing the tank with cling wrap to maintain humidity, and running lights without any water. Emersed growth is 3–4× faster than submersed and produces zero algae (no water column). After 4–6 weeks, flooding the established carpet results in competition-density coverage that would take 3–4 months submersed.",
            tags: ["cycling", "dry start method", "carpet plants", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q076", lessonID: "L01", difficulty: .intermediate,
            question: "Pure ammonia cycling produces a fully cycled tank faster than fish-in cycling because:",
            options: ["Ammonia is a more concentrated nitrogen source than fish waste", "Dosing can be precisely controlled, maintaining ideal 2–4 ppm ammonia for bacteria without the variable of fish stress and toxin sensitivity", "Pure ammonia contains no organic compounds that slow bacterial colonization", "Fish introduce competing bacteria strains that delay Nitrosomonas establishment"],
            correctIndex: 1,
            explanation: "Fish-in cycling requires conservative ammonia levels (below fish toxicity threshold) — limiting bacterial growth rate. Pure ammonia dosing maintains an optimal 2–4 ppm continuously, saturating bacterial capacity and accelerating colony development. A fish-in cycle takes 6–8 weeks; a pure ammonia cycle with daily testing reaches completion in 2–3 weeks.",
            tags: ["cycling", "fishless cycle", "nitrogen cycle", "intermediate"]
        ),

        // MARK: Flow & Circulation
        CompetitiveQuestion(
            id: "Q077", lessonID: "L11", difficulty: .intermediate,
            question: "The filter outlet spray bar should be positioned to create what type of water movement in a planted competition tank?",
            options: ["A direct flow aimed at the substrate surface to oxygenate roots", "Horizontal circulation across the water surface, creating a gentle rotating current without surface agitation that would outgas CO₂", "Vertical downward flow to push nutrients toward plant roots", "Aimed directly at the CO₂ diffuser to maximize dissolution"],
            correctIndex: 1,
            explanation: "Surface agitation removes dissolved CO₂ rapidly — every ripple is a CO₂ loss event. A spray bar positioned just below or at the surface level, aimed parallel to the water surface, creates gentle horizontal circulation. This distributes CO₂ and nutrients to all areas of the tank without the gas exchange that turbulent surface movement causes.",
            tags: ["filtration", "flow", "CO2 retention", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q078", lessonID: "L11", difficulty: .expert,
            question: "Dead spots (zero-flow areas) in a planted tank cause which specific problem that directly impacts competition readiness?",
            options: ["Excess nutrient accumulation feeding algae in high-flow areas", "Organic detritus settlement and anaerobic decomposition producing hydrogen sulfide pockets that poison roots and create localized substrate collapse", "Excess CO₂ concentration creating carbonic acid burn on nearby leaves", "Filter bacteria unable to colonize low-flow media sections"],
            correctIndex: 1,
            explanation: "Dead spots accumulate mulm (organic waste) that decomposes anaerobically, producing H₂S. This toxic gas creates localized root die-off — carpet plants above dead spots develop 'patches' of yellow-brown dying sections. Competition aquascapers use power heads, wavemakers, or spray bar adjustments to ensure even 0.2–0.5 cm/s flow across the entire substrate surface.",
            tags: ["filtration", "dead spots", "flow", "expert"]
        ),

        // MARK: Plant Species Knowledge
        CompetitiveQuestion(
            id: "Q079", lessonID: "L04", difficulty: .beginner,
            question: "Cryptocoryne wendtii is ideal for beginners in planted tanks because:",
            options: ["It grows completely without CO₂ or fertilizers", "It tolerates a wide range of water parameters and recovers quickly from transplant shock — 'Crypt melt' is temporary", "It is the fastest-growing Cryptocoryne species", "It is naturally resistant to all algae types"],
            correctIndex: 1,
            explanation: "C. wendtii is considered bulletproof — tolerating pH 5.5–8.0, soft to hard water, low to high light, with or without CO₂. The infamous 'Crypt melt' (sudden die-back after a parameter change) is temporary; the rhizome survives and regrows within 3–4 weeks. This resilience makes it the most forgiving midground plant for new competition aquascapers learning parameter management.",
            tags: ["plants", "cryptocoryne", "beginner-friendly", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q080", lessonID: "L04", difficulty: .intermediate,
            question: "Bucephalandra species have become popular in competition tanks primarily for what visual quality?",
            options: ["Their rapid growth filling large midground areas in weeks", "Their iridescent blue-purple shimmer on dark leaf surfaces — unique among aquatic plants and highly photogenic", "Their ability to outcompete algae on nearby hardscape", "Their tolerance for blackwater (pH 4–5) conditions"],
            correctIndex: 1,
            explanation: "Bucephalandra's iridescent leaf shimmer — caused by structural coloration similar to butterfly wing scales, not pigment — creates a blue-purple-green optical effect that is unique in the aquatic plant world. In competition photography under cool-spectrum LEDs, Bucephalandra surfaces appear to glow. Its slow growth (2–3 leaves/month) is offset by extremely long service life without trimming.",
            tags: ["plants", "bucephalandra", "iridescence", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q081", lessonID: "L04", difficulty: .expert,
            question: "What specific growth parameter causes Hemianthus callitrichoides (HC Cuba) to produce runners that grow upward rather than spreading horizontally?",
            options: ["Insufficient light causing etiolation — the plant grows toward the light source", "CO₂ levels above 35 mg/L triggering vertical stress response", "Excess nitrogen causing stem elongation instead of lateral runner production", "Substrate depth below 4 cm preventing lateral root anchoring"],
            correctIndex: 0,
            explanation: "HC Cuba etiolates under insufficient PAR — runners elongate vertically toward the light source instead of spreading laterally along the substrate. The minimum 80–100 µmol/m²/s PAR at substrate level forces the plant to prioritize horizontal growth. This is the most common failure mode for HC Cuba in 60cm tanks with lights designed for 30cm deep tanks.",
            tags: ["plants", "HC Cuba", "etiolation", "expert"]
        ),

        // MARK: Aquascape Styles Deep Dive
        CompetitiveQuestion(
            id: "Q082", lessonID: "L06", difficulty: .intermediate,
            question: "The classic Dutch style uses a strict 'terrace' arrangement. What does this describe?",
            options: ["Stone terraces creating elevation changes across the substrate", "Plants arranged in progressively taller species from front to back, with each species forming a distinct horizontal band", "Water flow directed in terraced steps from inlet to outlet", "Filter media arranged in layers of decreasing particle size"],
            correctIndex: 1,
            explanation: "Dutch terrace (trapveld) is the defining structural feature: foreground species under 5cm, midground 10–15cm, background 25–35cm+, arranged in precise horizontal bands with no species overlap. The front-to-back depth illusion is entirely created by plant height progression — unlike Nature Aquarium which uses substrate sloping and hardscape perspective.",
            tags: ["dutch style", "terrace", "composition", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q083", lessonID: "L06", difficulty: .expert,
            question: "In Dutch aquascaping, the 'group rule' states that species planted in groups should always be trimmed to what shape?",
            options: ["A natural irregular silhouette mimicking wild growth", "A convex dome shape — higher in the center, tapering at edges — to create visual mass and depth cues", "A flat horizontal plane aligned with neighboring groups", "A pointed triangular top to distinguish species from adjacent groups"],
            correctIndex: 1,
            explanation: "Dutch groups are trimmed to a convex dome — the center cut higher than the perimeter. This creates the impression each group is a three-dimensional volume rather than a flat panel. Multiple dome-trimmed groups at varying heights create a complex, layered visual texture that reads as a formal garden from a viewing distance. Flat-topped trimming is a common beginner error that makes groups appear painted-on.",
            tags: ["dutch style", "trimming technique", "expert"]
        ),

        // MARK: CO₂ Measurement
        CompetitiveQuestion(
            id: "Q084", lessonID: "L02", difficulty: .intermediate,
            question: "Why is a permanent pH probe more useful than a drop checker for managing CO₂ in competition tanks?",
            options: ["pH probes measure CO₂ directly, unlike drop checkers which only estimate", "pH probes show real-time changes, revealing the CO₂ ramp-up pattern throughout the photoperiod and detecting solenoid failures immediately", "pH probes are more accurate at high CO₂ concentrations above 30 mg/L", "Drop checkers work only in soft water; probes work at all hardness levels"],
            correctIndex: 1,
            explanation: "Drop checkers show a 1–2 hour lagged average due to diffusion time through the indicator fluid — useful for long-term calibration but useless for real-time management. A calibrated pH probe connected to a controller provides instant readings: CO₂ injection begins → pH drops → controller confirms target reached. It also alerts immediately if the solenoid fails to open, preventing a day of zero CO₂ and potential algae trigger.",
            tags: ["CO2", "pH probe", "monitoring", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q085", lessonID: "L02", difficulty: .expert,
            question: "What pH drop from pre-CO₂ (before lights and injection) to injection target indicates approximately 30 mg/L CO₂ in KH 3 water?",
            options: ["0.5 pH units", "1.0 pH unit", "1.5 pH units", "2.0 pH units"],
            correctIndex: 1,
            explanation: "The pH-KH-CO₂ triangle: for every doubling of CO₂, pH drops approximately 0.3 units. From baseline CO₂ (~3 mg/L at pH 7.5) to 30 mg/L requires roughly 10× increase = approximately 1.0 pH unit drop (to pH 6.5 at KH 3 dKH). This 1 pH unit rule is a reliable competition-setup shortcut when the KH is known — no tables required.",
            tags: ["CO2", "pH calculation", "KH", "expert"]
        ),

        // MARK: Fertilizer Methods
        CompetitiveQuestion(
            id: "Q086", lessonID: "L08", difficulty: .intermediate,
            question: "What is the 'Perpetual Preservation System' (PPS-Pro) fertilization method's key advantage over EI?",
            options: ["PPS-Pro requires no weekly water changes — nutrients are dosed to exact plant uptake, with zero accumulation", "PPS-Pro uses natural rock minerals instead of synthetic compounds", "PPS-Pro eliminates the need for CO₂ injection in high-light setups", "PPS-Pro is compatible with shrimp at twice the normal EI dosing rate"],
            correctIndex: 0,
            explanation: "PPS-Pro doses micro amounts daily to match plant uptake, maintaining near-zero residual nutrients — theoretically eliminating the need for large weekly water changes. The trade-off: it requires precise knowledge of plant demand (which varies with lighting, CO₂, and biomass) and careful monitoring. EI's brute-force approach is more forgiving for competition setups where any deficiency risks competition readiness.",
            tags: ["fertilization", "PPS-Pro", "method comparison", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q087", lessonID: "L08", difficulty: .expert,
            question: "Iron (Fe) becomes unavailable to plants above what pH level, regardless of total iron concentration in the water column?",
            options: ["pH 6.8", "pH 7.2", "pH 7.5", "pH 8.0"],
            correctIndex: 1,
            explanation: "Above pH 7.2, ferrous iron (Fe²⁺ — the bioavailable form) rapidly oxidizes to ferric iron (Fe³⁺), which precipitates out of solution as rust-brown particles. Plants cannot absorb Fe³⁺ without root-secreted chelation enzymes. At pH 7.5+, liquid iron supplements become useless within hours of dosing — explaining iron deficiency (interveinal chlorosis) in hard-water high-pH tanks even when iron test kits read positive.",
            tags: ["fertilization", "iron", "pH dependence", "expert"]
        ),

        // MARK: Competition Photography Advanced
        CompetitiveQuestion(
            id: "Q088", lessonID: "L10", difficulty: .intermediate,
            question: "What is the '90-minute CO₂ pre-photo' protocol used by competition photographers?",
            options: ["Running CO₂ at 50% normal rate for 90 minutes before shooting to reduce micro-bubble interference", "Starting CO₂ injection 90 minutes before the photography session to ensure plants are pearling actively at full saturation", "A 90-minute lighting ramp-up protocol to avoid the initial harsh light that over-exposes fine leaf detail", "Waiting 90 minutes after a water change before photographing to allow clarity to stabilize"],
            correctIndex: 1,
            explanation: "CO₂ must reach full saturation for pearling to occur — typically 60–90 minutes from injection start. Professional competition photographers schedule shoots 90 minutes into CO₂ injection, during peak pearling activity. This window produces: maximum oxygen bubble visual effect on leaves, highest plant color saturation, and the deepest blacks in shadowed substrate areas as bubbles refract light.",
            tags: ["photography", "pearling", "CO2 timing", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q089", lessonID: "L10", difficulty: .beginner,
            question: "What image aspect ratio do IAPLC entries use, and why is this significant for tank design?",
            options: ["4:3 (standard camera ratio)", "16:9 (widescreen)", "3:2 (standard DSLR)", "1:1 (square social media format)"],
            correctIndex: 2,
            explanation: "IAPLC requires 3:2 ratio (standard DSLR full-frame output) at minimum 2MB. This means competition tanks are designed to be photographed in the 3:2 frame — the tank's internal proportions (width:height) should consider how the 3:2 crop will frame the composition. Tanks built without considering the photographic frame often have compositional elements cut off or improperly centered in the final submission.",
            tags: ["photography", "IAPLC", "aspect ratio", "beginner"]
        ),

        // MARK: Paludarium & Aquascape Variants
        CompetitiveQuestion(
            id: "Q090", lessonID: nil, difficulty: .intermediate,
            question: "A paludarium differs from an aquascape in which fundamental design principle?",
            options: ["Paludariums use saltwater while aquascapes use freshwater", "Paludariums incorporate both a submerged aquatic zone and an emerged terrestrial zone above the waterline in the same enclosure", "Paludariums are judged in IAPLC while aquascapes are judged in AGA", "Paludariums prohibit the use of aquatic fish species"],
            correctIndex: 1,
            explanation: "A paludarium ('palus' = swamp, 'arium' = container) intentionally blurs the waterline — aquatic plants grow underwater, riparian plants grow in the transitional zone, and fully terrestrial plants grow above water. This creates the visual complexity of a riverbank or tropical river edge. The AGA competition has a dedicated paludarium category with separate judging criteria.",
            tags: ["paludarium", "aquascape styles", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q091", lessonID: nil, difficulty: .expert,
            question: "The 'biotope' category requires what level of geographical and ecological accuracy from entrants?",
            options: ["Plants and fish from the same continent is sufficient", "All flora, fauna, hardscape, and water parameters must accurately represent a specific, documented natural habitat from a verifiable geographical location", "At least 60% of species must originate from the same country", "Fish species accuracy is mandatory but plant species can be stylized interpretations"],
            correctIndex: 1,
            explanation: "True biotope competition (BAP — Biotope Aquarium Project) demands scientific accuracy: plants, fish, invertebrates, hardscape type, water chemistry (pH, TDS, temperature), and even substrate composition must match documented field research from a specific named river, lake, or habitat zone. Entrants submit bibliographic references. A 'Rio Negro biotope' with Amazonian fish but Asian hardscape stone is disqualified.",
            tags: ["biotope", "competition", "accuracy", "expert"]
        ),

        // MARK: Substrate Nutrients
        CompetitiveQuestion(
            id: "Q092", lessonID: "L08", difficulty: .intermediate,
            question: "Laterite substrates are no longer used in competition setups because they were replaced by what superior alternative?",
            options: ["Silica sand with root tabs every 5cm", "Purpose-formulated active substrates (ADA Amazonia, Tropica, UNS) that combine nutrient storage with optimal particle size and pH buffering", "Fluorite gravel with liquid fertilizer supplementation", "Bare bottom tanks with RODI water and pure liquid fertilization"],
            correctIndex: 1,
            explanation: "Laterite (iron-rich clay) was the 1990s competition substrate, popularized by Dupla and Dennerle. Active substrates introduced in the 2000s (ADA Amazonia 2002) replaced it entirely: active substrates buffer pH downward, contain cation-exchange capacity for all nutrients, have optimal particle size for carpet plant rooting, and release ammonia to jumpstart cycling — capabilities laterite lacks.",
            tags: ["substrate", "laterite", "history", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q093", lessonID: "L08", difficulty: .beginner,
            question: "Root tabs are most beneficial for which type of plant in a planted tank?",
            options: ["Floating plants like Salvinia and frogbit", "Heavy root-feeders like Echinodorus (swords) and Cryptocoryne in inert substrate setups", "Stem plants like Rotala which feed primarily through the water column", "Mosses and epiphytes attached to hardscape"],
            correctIndex: 1,
            explanation: "Root tabs deliver concentrated nutrients directly to the root zone — ideal for heavy root-feeders like Echinodorus (Amazon sword), Cryptocoryne, and Vallisneria which obtain 60–80% of their nutrients via roots rather than the water column. In active substrates (Amazonia), root tabs are unnecessary for the first 6–12 months as the substrate itself provides root-zone nutrition.",
            tags: ["fertilization", "root tabs", "root feeders", "beginner"]
        ),

        // MARK: Water Change Chemistry
        CompetitiveQuestion(
            id: "Q094", lessonID: "L01", difficulty: .expert,
            question: "Why do experienced aquascapers match the temperature of replacement water to within 1°C of the tank before water changes?",
            options: ["Temperature differences cause immediate fish death above 2°C differential", "Thermal shock disrupts bacterial colony biofilm integrity, temporarily reducing biological filtration capacity by up to 40%", "Cold water increases CO₂ solubility, crashing pH", "Temperature matching is a legal requirement in some country's animal welfare codes"],
            correctIndex: 1,
            explanation: "The biofilm matrix housing nitrifying bacteria is disrupted by sudden temperature changes. A 3°C cold-water flush can temporarily reduce biological filtration by 30–40%, causing a transient ammonia spike as bacterial metabolism slows. In a heavily stocked competition tank, this spike can cause fish stress and algae trigger events. Temperature-matched water changes are standard professional practice.",
            tags: ["water change", "temperature", "biological filtration", "expert"]
        ),

        // MARK: LED Technology
        CompetitiveQuestion(
            id: "Q095", lessonID: "L07", difficulty: .beginner,
            question: "What does CRI (Color Rendering Index) measure on LED fixtures, and what minimum CRI should competition aquascapers target?",
            options: ["CRI measures total light output in lumens — minimum 5000 lumens for planted tanks", "CRI measures how accurately colors appear under the light compared to natural sunlight (0–100 scale) — competition aquascapers target CRI 90+ for accurate plant color photography", "CRI measures the blue spectrum proportion useful for photosynthesis — minimum 30% blue for planted tanks", "CRI measures light spectrum stability over the fixture's lifespan — minimum CRI 70 for competition"],
            correctIndex: 1,
            explanation: "CRI 100 = identical color rendering to natural sunlight. Below CRI 80, reds appear orange, greens appear yellow-green, and photography requires heavy post-processing correction. Competition aquascapers use CRI 90+ fixtures: colors photograph accurately without post-processing, and the judge evaluating the submission sees colors as intended rather than as camera artifacts.",
            tags: ["lighting", "CRI", "LED", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q096", lessonID: "L07", difficulty: .intermediate,
            question: "The 'photoperiod crash' occurs when algae suddenly explodes after several algae-free weeks. What typically causes it?",
            options: ["Algae building immunity to the plant's allelopathic compounds after extended exposure", "A gradual reduction in CO₂ delivery (dirty diffuser, dropping cylinder pressure) causes plants to lose competitive advantage precisely as their biomass peaks and nutrient demand is highest", "Plant roots reaching the substrate glass and becoming root-bound", "LED diodes dimming below effective PAR threshold after 3000 hours of operation"],
            correctIndex: 1,
            explanation: "Peak growth weeks 5–8 require maximum CO₂. Diffusers accumulate calcium deposits over this period, reducing CO₂ output by 20–40%. Plants, stressed by CO₂ reduction, release organic exudates into high-nutrient water — perfect algae conditions. Cleaning the diffuser every 3–4 weeks (soaking in bleach solution, then dechlorinator rinse) prevents this predictable crash.",
            tags: ["lighting", "algae", "photoperiod crash", "intermediate"]
        ),

        // MARK: Scape Styles — Ryuboku
        CompetitiveQuestion(
            id: "Q097", lessonID: "L05", difficulty: .intermediate,
            question: "The 'Ryuboku' style (wood-dominated layout) became mainstream in IAPLC competition around which year, displacing Iwagumi as the dominant style?",
            options: ["2003–2005", "2008–2010", "2013–2015", "2018–2020"],
            correctIndex: 2,
            explanation: "Ryuboku (流木 — driftwood) dominated IAPLC submissions from 2013 onward, peaking around 2015–2017. The shift coincided with the availability of textured driftwood types (spider/azalea root, red moor wood) that enabled vertical forest compositions impossible with stone. By 2016, wood-based layouts occupied ~55% of top-100 IAPLC entries, compared to ~20% in 2010.",
            tags: ["ryuboku", "IAPLC history", "driftwood", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q098", lessonID: nil, difficulty: .expert,
            question: "Which aquascaper pioneered the 'forest floor' perspective — a low-angle, looking-up-through-the-canopy compositional approach — that won IAPLC Grand Prix in 2015?",
            options: ["Takayuki Fukada", "Filipe Oliveira", "Serkan Çetinkol", "Luca Galarraga"],
            correctIndex: 1,
            explanation: "Filipe Oliveira (Portugal) won the 2015 IAPLC Grand Prix with a low-viewing-angle forest floor composition using Azalea root that appeared to look upward through tree trunks toward a distant sky. This compositional breakthrough — treating the tank as a worm's-eye view rather than a landscape view — influenced hundreds of subsequent competition entries globally.",
            tags: ["IAPLC", "Filipe Oliveira", "forest floor", "expert"]
        ),

        // MARK: Maintenance Timing
        CompetitiveQuestion(
            id: "Q099", lessonID: "L12", difficulty: .beginner,
            question: "When is the ideal time within the photoperiod to perform plant trimming in a competition tank?",
            options: ["Immediately after CO₂ injection begins", "30–60 minutes before lights off, after the pearling window has passed", "At the photoperiod midpoint for maximum plant health benefit", "Immediately after lights turn on when plants are in low-metabolic state"],
            correctIndex: 1,
            explanation: "Trimming 30–60 minutes before lights off allows the water column to clear of plant fragments before the overnight period. Trimming during peak pearling (60–120 min into photoperiod) wastes the best growth period and stirs up debris into the photography window. Overnight, plants begin healing cut surfaces without photosynthetic stress, and the filter removes remaining particles by morning.",
            tags: ["maintenance", "trimming timing", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q100", lessonID: "L12", difficulty: .intermediate,
            question: "Why do competition aquascapers stop all fertilization exactly 72 hours before the photography session?",
            options: ["Fertilizers react with flash photography to create unwanted color casts", "Residual liquid iron and trace elements settle as fine brown particles that cloud the water — a 72-hour water-change-and-rest period produces competition-grade crystal clarity", "Fertilizers stimulate plant growth during the shoot, causing visible movement", "IAPLC rules prohibit fertilizers in the tank during the submission photograph"],
            correctIndex: 1,
            explanation: "Liquid iron (especially EDTA-chelated) and micronutrient mixes create invisible fine particulates that scatter light and reduce water clarity by 15–25%. A 72-hour window with no fertilization and a 30% water change on day one allows all suspended particles to settle or filter out, producing the water transparency that makes top-10 IAPLC photographs appear to show air rather than water.",
            tags: ["photography", "water clarity", "fertilization timing", "intermediate"]
        ),

        // MARK: Quick-Fire Facts
        CompetitiveQuestion(
            id: "Q101", lessonID: nil, difficulty: .beginner,
            question: "What is the scientific name of the plant commonly called 'Pearl Weed' — a popular competition foreground plant?",
            options: ["Glossostigma elatinoides", "Hemianthus micranthemoides", "Micranthemum Monte Carlo", "Eleocharis acicularis"],
            correctIndex: 1,
            explanation: "Hemianthus micranthemoides — 'Pearl Weed' — grows as a lush foreground or mid-ground plant with tiny round leaves that create a 'bubbling' texture. Not to be confused with the other Hemianthus, HC Cuba (H. callitrichoides). Pearl Weed is significantly more forgiving than HC Cuba and is used as a training plant by many aquascapers learning carpet technique.",
            tags: ["plants", "pearl weed", "nomenclature", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q102", lessonID: nil, difficulty: .intermediate,
            question: "How many species of Rotala are commonly available in the aquascaping trade?",
            options: ["3–5 species", "8–12 species", "25–35 species", "Over 60 species"],
            correctIndex: 2,
            explanation: "Approximately 25–35 Rotala species are actively traded in the aquascaping hobby, including R. rotundifolia, R. macrandra, R. wallichii, R. mexicana, R. 'H'ra', R. 'Vietnam', R. 'Singapore', R. florida, and many more. The genus exhibits enormous variation from ultra-fine needle-leaf types to broad-leaf varieties — making it the most species-diverse stem plant genus in competition use.",
            tags: ["plants", "rotala", "species diversity", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q103", lessonID: nil, difficulty: .expert,
            question: "Vallisneria should NOT be planted in the same tank as CO₂-injected stem plants because:",
            options: ["Vallisneria produces allelopathic compounds that inhibit stem plant root development", "At pH below 7.0 (required for CO₂ efficiency), Vallisneria chloroses and dies — it requires alkaline conditions that conflict with CO₂ injection targets", "Vallisneria consumes CO₂ faster than other plants, starving stem plants", "Vallisneria's ribbon-like leaves block circulation to nearby stem plants"],
            correctIndex: 1,
            explanation: "Vallisneria requires pH 7.0–8.0 and moderate-high KH — conditions that produce inadequate CO₂ saturation for demanding stem plants and carpet species. CO₂-injected competition tanks maintain pH 6.5–6.8 (KH 2–4), which causes Vallisneria interveinal chlorosis and eventual death within 2–3 weeks. They are fundamentally incompatible with the chemistry required for high-tech competition setups.",
            tags: ["plants", "vallisneria", "pH incompatibility", "expert"]
        ),
        CompetitiveQuestion(
            id: "Q104", lessonID: nil, difficulty: .beginner,
            question: "What does 'liquid carbon' (glutaraldehyde) do when applied directly to algae spots on hardscape?",
            options: ["It dissolves algae cells on contact by disrupting their cell walls", "It stains the algae making it easier to remove manually", "It creates an acidic micro-environment that suffocates algae", "It coats the surface preventing new algae spore attachment"],
            correctIndex: 0,
            explanation: "Glutaraldehyde (sold as Seachem Excel, TNC Carbon, etc.) is a biocide that denatures proteins in algae cell walls on direct contact — turning them white-brown within minutes. Applied via syringe with tank circulation paused, it effectively spot-treats BBA and staghorn algae on hardscape without harming established plants. Full dosing into the water column also inhibits algae growth systemically.",
            tags: ["algae", "glutaraldehyde", "spot treatment", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q105", lessonID: nil, difficulty: .intermediate,
            question: "The 'estimative' in Tom Barr's Estimative Index refers to:",
            options: ["Estimating plant nutrient requirements through leaf color observation", "Dosing nutrients based on estimated plant uptake rather than precise measurement — excess is assumed and reset weekly", "Estimating CO₂ levels without a drop checker by observing plant behavior", "Using an estimated water change schedule based on fish load rather than testing"],
            correctIndex: 1,
            explanation: "Tom Barr explicitly named EI 'Estimative' because it abandons precise measurement entirely. Rather than testing water and dosing to deficiency, the system doses based on estimated maximum plant uptake — deliberately aiming above requirement. The weekly 50% water change resets any accumulation. The philosophy: it is easier to reliably dose above need than to precisely match actual uptake which varies daily.",
            tags: ["fertilization", "EI method", "Tom Barr", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q106", lessonID: nil, difficulty: .expert,
            question: "In the NPT (Natural Planted Tank) low-tech method developed by Diana Walstad, what eliminates the need for CO₂ injection and liquid fertilizers?",
            options: ["A dense surface plant layer that eliminates CO₂ demand", "Organic soil substrate releasing CO₂ and nutrients continuously as organic matter decomposes aerobically", "High fish load providing sufficient CO₂ through respiration", "Specially selected bacteria that fix atmospheric CO₂ directly into plant-available form"],
            correctIndex: 1,
            explanation: "Walstad's method uses garden soil or organic potting mix capped with gravel. Decomposing organic matter in the soil continuously releases CO₂ (via aerobic bacterial respiration) and nutrients directly at the root zone. At moderate light levels, this matches plant CO₂ demand without injection. The system reaches equilibrium in 3–6 months and can sustain plant growth indefinitely — though not at competition-grade growth rates.",
            tags: ["low-tech", "Walstad method", "NPT", "expert"]
        ),

        // MARK: Aquascape Scale & Perspective
        CompetitiveQuestion(
            id: "Q107", lessonID: "L03", difficulty: .intermediate,
            question: "What technique do competition aquascapers use to create the illusion of vast distance in a 60cm tank?",
            options: [
                "Using a wide-angle lens with extreme distortion",
                "Placing fine-textured plants at the back and coarse-textured plants at the front — mimicking how texture detail fades with real distance",
                "Painting the back glass with a gradient background",
                "Filling the background entirely with fast-growing stem plants"
            ],
            correctIndex: 1,
            explanation: "Atmospheric perspective: fine-textured plants (Rotala wallichii, mini mosses) at the back appear 'distant.' Coarser plants (Anubias, broad Crypts) at the front appear 'close.' The brain reads this texture gradient as depth — a compositional trick that can make a 60cm tank read as a 10-metre landscape in photographs.",
            tags: ["composition", "perspective", "scale illusion", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q108", lessonID: "L03", difficulty: .expert,
            question: "In photography of large aquascapes (120cm+), what problem does a wide-angle lens introduce that professional competition photographers actively compensate for?",
            options: [
                "Wide-angle lenses reduce the apparent depth of field, blurring background plants",
                "Barrel distortion curves straight horizontal lines (substrate surface, waterline) making the tank appear bowed",
                "Wide-angle lenses require longer exposure times, increasing motion blur from fish",
                "They reduce colour saturation in the red spectrum, harming Rotala photography"
            ],
            correctIndex: 1,
            explanation: "Barrel distortion from wide-angle lenses curves the substrate and waterline outward, making the tank appear to bulge. Competition photographers either shoot with a standard or mild wide lens (35–50mm equivalent) or correct distortion in post-processing using lens profile correction. For IAPLC judging, a visibly bowed substrate line is penalised under the 'technical quality' criterion.",
            tags: ["photography", "wide-angle", "distortion", "expert"]
        ),

        // MARK: Temperature & Plant Physiology
        CompetitiveQuestion(
            id: "Q109", lessonID: "L04", difficulty: .intermediate,
            question: "Why do most competition aquascapers maintain water temperature at 24–26°C rather than the 28–30°C some tropical fish prefer?",
            options: [
                "Higher temperatures reduce CO₂ solubility, requiring significantly more injection to maintain target levels",
                "Fish grow larger at higher temperatures, creating more bioload",
                "Higher temperatures accelerate algae reproduction exclusively",
                "Heater equipment is more reliable below 26°C"
            ],
            correctIndex: 0,
            explanation: "CO₂ solubility decreases as temperature rises — at 28°C you need approximately 30% more CO₂ injection to achieve the same dissolved concentration as at 24°C. Lower temperature also reduces plant metabolic rate slightly, producing denser, more compact growth — aesthetically superior for competition. Most stem plants and carpet species perform best at 24–25°C.",
            tags: ["water chemistry", "temperature", "CO2 solubility", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q110", lessonID: "L04", difficulty: .beginner,
            question: "Eleocharis parvula (dwarf hairgrass) spreads via which mechanism in a planted tank?",
            options: [
                "Sexual reproduction — releasing seeds into the water column",
                "Horizontal stolons (runners) that spread laterally just below the substrate surface",
                "Spore release similar to ferns and mosses",
                "Rhizome division triggered by light intensity"
            ],
            correctIndex: 1,
            explanation: "Dwarf hairgrass spreads via stolons — thin horizontal stems that run just below the substrate surface and send up new grass shoots every 2–4 cm. With adequate light (60+ PAR), CO₂, and nutrients, a single plug fills a 30cm foreground area in 6–8 weeks. Trimming to 3–4 cm encourages faster stolonning by redirecting energy from height growth to lateral spread.",
            tags: ["plants", "hairgrass", "propagation", "beginner"]
        ),

        // MARK: Potassium & Micro Nutrients
        CompetitiveQuestion(
            id: "Q111", lessonID: "L08", difficulty: .intermediate,
            question: "Potassium (K) deficiency in aquatic plants shows as which symptom, often mistaken for iron deficiency?",
            options: [
                "Overall yellowing of all leaves uniformly",
                "Pinhole perforations and ragged holes appearing in older leaves, with yellow leaf edges",
                "Interveinal chlorosis on new growth only",
                "Black tips on stem plant shoot tips"
            ],
            correctIndex: 1,
            explanation: "Potassium deficiency produces pinhole perforations and marginal yellowing on older leaves — a symptom unique enough to distinguish it from iron deficiency (interveinal chlorosis on young leaves). K is mobile in plants: deficiency symptoms appear on old leaves first. Potassium is consumed heavily in high-light, CO₂-injected tanks and must be dosed separately in EI — potassium sulphate (K₂SO₄) is the standard supplement.",
            tags: ["fertilization", "potassium", "deficiency symptoms", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q112", lessonID: "L08", difficulty: .expert,
            question: "Why is boron (B) an essential micronutrient for aquatic plants despite being required in extremely small quantities (0.01–0.05 mg/L)?",
            options: [
                "Boron activates the enzymes responsible for chlorophyll synthesis",
                "Boron is required for cell wall formation and pollen tube growth — deficiency causes deformed new growth tips and shoot die-back",
                "Boron acts as a pH buffer at the cellular level, preventing internal acidosis",
                "Boron enables the plant to absorb phosphate in soft-water conditions"
            ],
            correctIndex: 1,
            explanation: "Boron is critical for cell wall pectin cross-linking — without it, new cell walls cannot form correctly. Deficiency symptoms appear at growing tips first: twisted, thickened, or aborted new leaves. In planted tanks using RO water without comprehensive remineralisation, boron is frequently omitted and causes stunted new growth that is misdiagnosed as calcium deficiency.",
            tags: ["fertilization", "boron", "micronutrients", "expert"]
        ),

        // MARK: Shrimp Advanced
        CompetitiveQuestion(
            id: "Q113", lessonID: "L11", difficulty: .intermediate,
            question: "Crystal Red Shrimp (CRS) require what water parameters that conflict with typical competition stem plant setups?",
            options: [
                "High KH (8+ dKH) and alkaline pH for shell formation",
                "Very soft water (TDS 100–150, pH 5.8–6.5, KH 0–2) — softer than optimal for most stem plants",
                "High nitrate (20–40 ppm) as a nitrogen source for moulting",
                "Warm temperature (28–30°C) that maximises their immune function"
            ],
            correctIndex: 1,
            explanation: "CRS thrive in near-distilled conditions — TDS 100–150 ppm, pH 5.8–6.5, KH 0–2 dKH. This is softer than the KH 2–4 that many competition plants prefer, and far softer than tap water. Tanks combining CRS and demanding stem plants require a careful balance on the softer end of both species' tolerance ranges — achievable but requiring precise RO remineralisation management.",
            tags: ["invertebrates", "CRS", "water parameters", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q114", lessonID: "L11", difficulty: .beginner,
            question: "Why should copper-containing medications never be used in planted tanks with shrimp?",
            options: [
                "Copper reacts with plant tannins to form compounds that damage the filter",
                "Shrimp use copper-based haemocyanin as their blood oxygen carrier — external copper disrupts respiratory protein function and is lethal at trace concentrations",
                "Copper raises GH to levels harmful for most aquatic plants",
                "Copper-based medications require pH above 8.0 to activate, which crashes CO₂ levels"
            ],
            correctIndex: 1,
            explanation: "Shrimp (and many invertebrates) use haemocyanin — a copper-containing protein — to carry oxygen in their blood. External copper from medications competes with and denatures haemocyanin, causing respiratory failure. Shrimp die at copper concentrations below 0.05 mg/L — far below levels harmful to fish. Always verify any medication or supplement is explicitly labelled invertebrate-safe.",
            tags: ["invertebrates", "shrimp", "copper toxicity", "beginner"]
        ),

        // MARK: Aquascape History
        CompetitiveQuestion(
            id: "Q115", lessonID: nil, difficulty: .intermediate,
            question: "Who is considered the 'father of Dutch aquascaping' and what decade did he begin formalising the style?",
            options: [
                "Takashi Amano — formalised in the 1980s",
                "Dirk Hendrik Ballendux — formalised in the 1950s through the NBAT society",
                "George Booth — formalised in the 1970s via the Usenet aquarium group",
                "Karel Rataj — formalised in the 1960s through Czech botanical research"
            ],
            correctIndex: 1,
            explanation: "The NBAT (Nederlandse Bond Aqua Terra) — the Dutch Aquarium Society — formalised Dutch style judging criteria in the 1950s. Dirk Hendrik Ballendux was among the key figures who established the terrace structure, group planting rules, and craftsmanship criteria still used today. Dutch style predates Nature Aquarium by approximately 30 years and remains Europe's dominant competition form.",
            tags: ["history", "dutch style", "NBAT", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q116", lessonID: nil, difficulty: .expert,
            question: "Takashi Amano's 'Nature Aquarium World' book trilogy (1994–1996) was significant for the hobby primarily because:",
            options: [
                "It introduced CO₂ injection technology to the hobby for the first time",
                "It was the first time large-format photography showed aquascapes as art rather than fish tanks — reframing the entire aesthetic ambition of planted aquaria globally",
                "It provided the first scientific analysis of aquatic plant nutrition in the hobby",
                "It established the IAPLC competition rules and scoring system"
            ],
            correctIndex: 1,
            explanation: "Before Amano's books, aquarium photography showed fish collections. Nature Aquarium World presented aquascapes as landscape photographs — equivalent to nature photography. The visual standard shifted globally within a decade: hobbyists began designing for the photograph rather than for the fish. The books sold over 200,000 copies and were translated into 12 languages, making them the most influential aquascaping publications in history.",
            tags: ["history", "Amano", "Nature Aquarium World", "expert"]
        ),

        // MARK: Tank Hardscape — Rocks Advanced
        CompetitiveQuestion(
            id: "Q117", lessonID: "L05", difficulty: .intermediate,
            question: "Ohko stone (Dragon Stone) is chemically safe for low-KH competition tanks because:",
            options: [
                "It is calcium carbonate like Seiryu but coated with non-leaching silica",
                "It is composed primarily of clay minerals and iron oxides — it does not contain calcium carbonate and does not affect KH",
                "It releases small amounts of potassium that benefit plant growth",
                "Its porous surface neutralises the leaching compounds before they reach the water column"
            ],
            correctIndex: 1,
            explanation: "Dragon Stone (Ohko) is a sedimentary clay-iron rock — geologically unrelated to limestone. It contains no calcium carbonate, releases no KH-raising compounds, and is chemically inert in normal aquarium conditions. This makes it the preferred alternative to Seiryu stone for aquascapers targeting KH 2–4 dKH — identical visual aesthetic (layered texture, pale grey tones) without the chemistry conflict.",
            tags: ["hardscape", "ohko stone", "KH neutral", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q118", lessonID: "L05", difficulty: .beginner,
            question: "What is the 'grain direction' rule when placing stones in an Iwagumi layout?",
            options: [
                "All stones must be sourced from the same geological layer for consistent density",
                "All stones must be oriented so their visible strata lines run in the same direction — creating visual unity as if from one continuous rock formation",
                "The largest stone's grain must run perpendicular to the substrate for structural stability",
                "Grain direction only applies to sandstone; igneous rocks are placed freely"
            ],
            correctIndex: 1,
            explanation: "Stone strata lines (grain) must be aligned across all stones in the layout. If the Oyaishi's lines run diagonally left-to-right, all supporting stones must mirror this angle. Misaligned grain reads as 'different rocks placed together' — destroying the illusion of a single natural geological formation. This is the most commonly judged technical error in beginner Iwagumi entries.",
            tags: ["hardscape", "iwagumi", "grain direction", "beginner"]
        ),

        // MARK: Tannins & Blackwater
        CompetitiveQuestion(
            id: "Q119", lessonID: "L01", difficulty: .intermediate,
            question: "In a blackwater biotope setup (Rio Negro style), what chemical effect do leaf litter tannins provide that benefits the ecosystem?",
            options: [
                "They provide carbon as a direct plant nutrient supplement",
                "They lower pH and release humic acids that act as natural chelators, making trace minerals bioavailable and inhibiting bacterial pathogens",
                "They increase KH, buffering pH against CO₂-induced drops",
                "They absorb excess ammonia from fish waste via ion exchange"
            ],
            correctIndex: 1,
            explanation: "Tannins and humic acids in blackwater perform multiple functions: lowering pH to 4–6 (native range for Altum angelfish, wild discus, most wild Amazonian species), acting as natural chelators that keep iron and other traces dissolved at low pH, and exhibiting mild antibacterial/antifungal properties that reduce pathogen load. Wild-caught fish from blackwater systems often fail to thrive without some tannin supplementation.",
            tags: ["blackwater", "tannins", "humic acids", "intermediate"]
        ),

        // MARK: Emerging Techniques
        CompetitiveQuestion(
            id: "Q120", lessonID: "L12", difficulty: .expert,
            question: "The 'dry hardscape design' technique involves arranging the entire hardscape in an empty tank before adding substrate. What is the critical advantage of this approach?",
            options: [
                "Dry stone is lighter and easier to reposition during the design phase",
                "The aquascaper can evaluate composition from all angles, adjust grain alignment, bury ratios, and golden ratio positioning before substrate locks everything in permanently",
                "Dry arrangement prevents calcium leaching from stone during the initial design period",
                "Substrate cannot be added evenly around stones that are already wet"
            ],
            correctIndex: 1,
            explanation: "Once substrate is added and the tank is filled, repositioning stones disturbs the carpet planting and substrate slope — often irreversibly. Dry hardscape design allows unlimited iteration: photograph each arrangement, compare perspectives, verify grain alignment, and achieve the precise Golden Ratio focal point before substrate is ever poured. Top competition aquascapers spend 2–4 days on dry hardscape design before committing.",
            tags: ["technique", "hardscape design", "dry layout", "expert"]
        ),
        CompetitiveQuestion(
            id: "Q121", lessonID: "L10", difficulty: .intermediate,
            question: "What is 'focus stacking' in aquascape photography, and when is it used?",
            options: [
                "Combining multiple exposures at different ISO settings to create a noise-free composite",
                "Taking multiple shots focused at different depths, then combining them in post-processing to achieve front-to-back sharpness impossible in a single frame",
                "Stacking neutral density filters to extend shutter speed for motion blur effects",
                "A bracketing technique for HDR aquascape images under mixed lighting"
            ],
            correctIndex: 1,
            explanation: "Focus stacking captures 3–10 frames, each focused at a different depth plane (foreground carpet → midground stones → background plants). Software merges the sharp zone of each frame into a composite with total depth of field. Used for extreme macro aquascape photography where even f/11 cannot achieve front-to-back sharpness — common in nano tank photography where the camera-to-subject distance is very short.",
            tags: ["photography", "focus stacking", "depth of field", "intermediate"]
        ),

        // MARK: Aquatic Plant Morphology
        CompetitiveQuestion(
            id: "Q122", lessonID: "L04", difficulty: .beginner,
            question: "What is the difference between 'emersed' and 'submersed' leaf forms in aquatic plants?",
            options: [
                "Emersed leaves grow above water; submersed leaves grow underwater — many species show dramatically different leaf shapes in each form",
                "Emersed means the root is exposed; submersed means the root is buried in substrate",
                "Emersed growth occurs in winter; submersed growth occurs in summer for seasonal aquatic species",
                "Emersed leaves are broader; submersed leaves are narrower in all aquatic species"
            ],
            correctIndex: 0,
            explanation: "Many aquatic plants grow completely differently above and below water. Hygrophila polysperma emersed has broad oval leaves; submersed leaves are smaller and more delicate. Bacopa caroliniana emersed has thick succulent leaves; submersed leaves are thinner and more translucent. Understanding both forms helps aquascapers identify plants purchased from nurseries (usually emersed) and anticipate what they will look like after transitioning.",
            tags: ["plants", "emersed vs submersed", "morphology", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q123", lessonID: "L04", difficulty: .expert,
            question: "Why does Pogostemon helferi (Downoi) grow in a rosette pattern rather than as a stem plant, despite technically being a stem plant species?",
            options: [
                "Its stem is too fragile to support vertical growth against water current",
                "It has extremely short internodal spacing — each new leaf emerges so close to the last that the plant appears as a flat rosette rather than a vertical stem",
                "It requires anaerobic substrate conditions that prevent upright root anchoring",
                "It is a genetic mutation of a naturally upright Thai species that arose in captive aquarium conditions"
            ],
            correctIndex: 1,
            explanation: "P. helferi has internodal spacing of 1–3mm versus the 5–20mm typical of most stem plants — so tight that 10 internodes still appear as a flat rosette to the naked eye. This unique growth habit makes it ideal as a mid-foreground 'textural accent' plant — it reads as a rosette plant aesthetically but is trimmed and propagated exactly like a stem plant (cut and replant).",
            tags: ["plants", "pogostemon helferi", "growth habit", "expert"]
        ),

        // MARK: Equipment — Heaters & Controllers
        CompetitiveQuestion(
            id: "Q124", lessonID: "L11", difficulty: .beginner,
            question: "Why do competition aquascapers place the heater near the filter inlet rather than the outlet?",
            options: [
                "Heating water before filtration prevents thermal damage to filter bacteria",
                "Cold tank water enters the filter, is heated as it passes the heater, then distributed evenly by the filter outlet — preventing hot spots near the heater",
                "The filter outlet creates too much turbulence for accurate heater thermostat readings",
                "Heater placement near the inlet reduces evaporation rate"
            ],
            correctIndex: 1,
            explanation: "Heater near the inlet draws the coldest tank water past the heating element, providing maximum thermal differential for the thermostat to work efficiently. The heated water then passes through the filter and returns via the outlet, distributing warmth throughout the tank. Placement near the outlet heats already-warm water, creating local hot zones and thermostat cycling inefficiency.",
            tags: ["equipment", "heater placement", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q125", lessonID: "L11", difficulty: .intermediate,
            question: "An Aquarium Controller (e.g. Neptune Apex, GHL ProfiLux) improves competition readiness primarily by:",
            options: [
                "Automatically adding fertilizers via dosing pumps calibrated to plant growth algorithms",
                "Monitoring pH, temperature, and conductivity 24/7 with automatic solenoid control — preventing the undetected CO₂ failures and temperature spikes that trigger algae and fish stress",
                "Adjusting lighting spectrum in real time based on plant photosynthesis sensors",
                "Automatically performing water changes when TDS exceeds preset thresholds"
            ],
            correctIndex: 1,
            explanation: "Aquarium controllers run continuous monitoring loops — if pH rises above target (indicating CO₂ failure) the controller sends an alert immediately. Temperature probes detect heater malfunctions before fish experience stress. For an IAPLC competitor with 16 weeks invested in a tank, preventing a single overnight solenoid failure or heater runaway event justifies the controller's cost entirely.",
            tags: ["equipment", "controller", "monitoring", "intermediate"]
        ),

        // MARK: Competitive Mindset
        CompetitiveQuestion(
            id: "Q126", lessonID: nil, difficulty: .beginner,
            question: "What is the single most common reason IAPLC entries score below 70 points (out of 100), according to published judge commentary?",
            options: [
                "Poor water quality and algae visible in the photograph",
                "Lack of a single clear visual concept — too many competing ideas without one dominant theme",
                "Incorrect species identification in the plant list submission",
                "Using artificial decorations alongside natural materials"
            ],
            correctIndex: 1,
            explanation: "Judges consistently report that sub-70 entries lack 'a story' — they contain technically competent elements (healthy plants, clean maintenance) but no unified visual narrative. A composition trying to be both an Iwagumi and a forest simultaneously achieves neither. The single clearest piece of advice from grand prize winners: 'decide what you are making and eliminate everything that is not that thing.'",
            tags: ["IAPLC", "judging", "visual concept", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q127", lessonID: nil, difficulty: .intermediate,
            question: "In competition aquascaping, what does the term 'visual flow' describe?",
            options: [
                "The direction of water current created by the filter outlet",
                "The path the viewer's eye travels through the composition — from entry point through focal elements and back — without jumping or stopping unexpectedly",
                "The growth direction of stem plants as they respond to lighting position",
                "The rate at which pearling oxygen bubbles rise through the water column"
            ],
            correctIndex: 1,
            explanation: "Visual flow is the compositional quality that guides the viewer's gaze on a predetermined journey through the aquascape. In a successful Iwagumi: eye enters at the foreground carpet → travels to the Oyaishi along the stone line → continues to the background planting → returns via the open substrate. Interruptions (a misplaced stone, an out-of-scale plant, an isolated colour patch) break flow and force the eye to stop — reducing the meditative quality judges score as 'harmony.'",
            tags: ["composition", "visual flow", "aesthetics", "intermediate"]
        ),
        CompetitiveQuestion(
            id: "Q128", lessonID: nil, difficulty: .expert,
            question: "The 'negative space paradox' in Iwagumi design states that adding more open carpet area can make the composition feel MORE complex. Why?",
            options: [
                "Empty substrate reflects light differently, creating additional depth layers",
                "Open space increases the visual weight of hardscape elements — making each stone appear more monumental and the total composition more architecturally complex",
                "Negative space allows viewer imagination to add detail, making the brain process the scene more deeply",
                "Carpet plants in open areas grow more densely due to reduced competition, adding texture complexity"
            ],
            correctIndex: 1,
            explanation: "Visual weight is relative — a stone surrounded by dense plants competes with them. The same stone surrounded by open carpet commands the entire composition. This is why minimalist Iwagumi with 70% open foreground often score higher than densely planted compositions: each stone element, freed from competition, achieves maximum visual authority. Amano called this 'giving the stones room to speak.'",
            tags: ["iwagumi", "negative space", "visual weight", "expert"]
        ),
        CompetitiveQuestion(
            id: "Q129", lessonID: "L09", difficulty: .beginner,
            question: "Green spot algae (GSA) appearing on slow-growing leaves like Anubias and Cryptocoryne typically indicates a deficiency in which nutrient?",
            options: ["Nitrogen (NO₃)", "Phosphate (PO₄)", "Iron (Fe)", "Potassium (K)"],
            correctIndex: 1,
            explanation: "GSA (Coleochaete orbicularis) colonises hard surfaces and slow-growing leaves when phosphate is low. Plants rapidly uptake phosphate, leaving residual levels near zero — GSA exploits this deficiency, thriving on surfaces where plant competition for phosphate is low. Raising PO₄ to 0.5–1.0 ppm via potassium phosphate (KH₂PO₄) dosing resolves most GSA outbreaks within 2–3 weeks without causing other algae.",
            tags: ["algae", "GSA", "phosphate deficiency", "beginner"]
        ),
        CompetitiveQuestion(
            id: "Q130", lessonID: "L02", difficulty: .beginner,
            question: "What does a CO₂ bubble counter actually measure, and why is it insufficient as a sole CO₂ monitoring tool?",
            options: [
                "It measures dissolved CO₂ in mg/L — it is the most accurate CO₂ measurement available",
                "It counts bubbles per second — indicating injection rate, not dissolved concentration, which varies with diffuser efficiency, water flow, and temperature",
                "It measures pressure in the CO₂ line — useful for detecting cylinder pressure drop",
                "It measures the pH impact of CO₂ in real time via an integrated sensor"
            ],
            correctIndex: 1,
            explanation: "A bubble counter only shows injection rate — not how much CO₂ actually dissolves. A dirty diffuser might pass the same bubble count but dissolve 40% less CO₂. Temperature changes alter solubility. A drop checker or pH probe measures actual dissolved CO₂ — the bubble counter is just a flow rate indicator used to ensure the solenoid is open and the system is running, not to calibrate dosing levels.",
            tags: ["CO2", "bubble counter", "monitoring", "beginner"]
        ),
    ]
}
