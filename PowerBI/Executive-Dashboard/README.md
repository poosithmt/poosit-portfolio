# 📊 Executive Strategic Dashboard: Financial & Operational Intelligence

## 📌 Project Overview
This project delivers a high-impact **Business Intelligence Solution** designed for C-suite executives and senior leadership. The primary objective was to transform complex, multi-dimensional sales datasets into a **"Single Source of Truth."** By focusing on a **Minimalist & Insight-First** philosophy, this dashboard eliminates data noise and provides a streamlined experience for monitoring KPIs, identifying growth opportunities, and making data-driven strategic decisions.

## 🔗 Live Interactive Dashboard
> **[👉 Click Here to View the Full Interactive Report](https://app.powerbi.com/view?r=eyJrIjoiNzIyYmQwMGYtNTA4MS00ODQ4LWFlN2MtMDZhYjgxZjVhOWZiIiwidCI6ImZkMjA2NzE1LTc1MDktNGFlNS05Yjk2LTc2YmI5Nzg4NmE4NCIsImMiOjEwfQ%3D%3D)**
>
> *Note: For the best experience, please view in Full-Screen mode on a desktop.*

---

## 🛠️ Project Methodology (Step-by-Step)

### 1. Requirements Gathering & KPI Strategy
I defined the report's framework based on 4 critical business pillars to ensure alignment with executive goals:
* **Revenue & Profitability:** Tracking the overall financial health of the organization.
* **Growth Dynamics:** Analyzing Year-over-Year (YoY) variances to detect market shifts.
* **Market Intelligence:** Deep-diving into regional performance and customer segments.
* **Operational Flow:** Monitoring order volumes and transaction trends to optimize the supply chain.

### 2. Data Transformation (ETL) & Modeling
Using **Power Query**, I processed the raw data to ensure absolute accuracy and performance:
* **Data Cleaning:** Handled null values, removed redundancies, and standardized data types for financial consistency.
* **Calendar Engineering:** Developed a comprehensive Date Table to support advanced Time Intelligence and trend analysis.
* **Star Schema Optimization:** Structured the data model with optimized relationships (Fact and Dimension tables) to ensure high-speed report interactivity and scalability.

### 3. Advanced DAX Engineering
To provide a seamless and interactive user experience, I developed custom DAX measures that handle dynamic interactions and high-end visual logic:
* **Dynamic Metric Switching:** Built a robust toggle system allowing users to switch the entire report view between Revenue, Profit, Quantity, and Orders.
* **SVG Visual Integration:** Wrote custom SVG code to embed Sparklines and Gauges directly into data tables, providing high-density information without clutter.
* **Conditional Formatting Logic:** Created dynamic strings to handle currency symbols and unit scaling (K, M) based on the selected metric.

---

## 💻 Technical Showcase: Advanced DAX Logic

### **I. Dynamic Metric Selector**
*Enables the executive to switch the focus of the entire report instantly using a single slicer.*
```dax
Selected Metric = 
VAR sel = SELECTEDVALUE(Metric[Type])
RETURN
    SWITCH(
        TRUE(),
        sel = 0, [Revenue],
        sel = 1, [Profit],
        sel = 2, [Quantity],
        sel = 3, [Orders]
    )
```

### **II. Dynamic Data Label Formatting**
*Automatically adjusts currency symbols and units (Millions/Thousands) based on the metric value.*
```dax
Data Label for Top Products = 
VAR selProduct = SELECTEDVALUE('Product'[Product Name])
VAR metric = SELECTEDVALUE(Metric[Type])

VAR format_ = 
    SWITCH(
        TRUE(),
        metric = 0, IF( [Revenue] > 1000000, FORMAT( [Revenue], "$0,,.0M"), FORMAT( [Revenue], "$0,.0K")),
        metric = 1, IF( [Profit] > 1000000, FORMAT( [Profit], "$0,,.0M"), FORMAT( [Profit], "$0,.0K")),
        metric = 2, IF( [Quantity] > 1000, FORMAT( [Quantity], "0,.0K"), FORMAT( [Quantity], "#,##0")),
        metric = 3, FORMAT( [Orders], "#,##0")
    )
RETURN
    selProduct & " | " & format_
```

### **III. YoY Variance with Dynamic Icons**
*Provides immediate visual context on performance trends compared to the previous year.*
```dax
Revenue Icon YoY = 
    IF(
        NOT ISBLANK([PY Rev.]),
        IF(
            [Δ % YoY Revenue] > 0,
            "+" & FORMAT([Δ % YoY Revenue], "0.0%") & " ▲", 
            FORMAT([Δ % YoY Revenue], "0.0%") & " ▼"
        ),
        "" 
    )
```

### **IV. Custom SVG Sparkline Trend**
*A high-performance visual alternative to bulky charts, rendered directly via DAX.*
```dax
Order Adjustable Sparkline = 
// Renders a sleek line chart using SVG coordinates for monthly trends
VAR Lines = CONCATENATEX(SparklineTable, [X] & "," & 50-[Y], " ", 'Calendar'[Month])

VAR SVGImageURL = 
    "data:image/svg+xml;utf8," & 
    "<svg xmlns='http://www.w3.org/2000/svg' viewBox='-7 -7 164 64'>" & 
    "<polyline fill='none' stroke='#865EFF' stroke-width='2' points='" & Lines & "'/>" &
    "<circle cx='"& LastSparkXValue & "' cy='" & 50 - LastSparkYValue & "' r='4' fill='#865EFF' />" &
    "</svg>"
RETURN SVGImageURL
```

### **V. Dynamic Pie Chart (SVG)**
*Custom-coded SVG Gauge to visualize market share percentage within a table.*
```dax
_PieChart for top 5 state = 
    VAR Percentage = [Selected Metric]/CALCULATE([Selected Metric], ALL(State))
    VAR XArcEnd = sin(RADIANS(180 - (Percentage * 360)))*.8
    VAR YArcEnd = cos(RADIANS(180 - (Percentage * 360)))*.8
    VAR Arc ="<path d='M 0 -.8 A 0.8 0.8 0 0 1 " & XArcEnd & " " & YArcEnd & " L 0 0 z' fill='#865EFF'></path>"
    RETURN "data:image/svg+xml;utf8,<svg viewBox='-1 -1 2 2'>" & Arc & "</svg>"
```

## 📈 Strategic Business Insights
* **Segment Growth:** Identified a significant revenue surge in specific market segments, allowing for targeted marketing resource allocation.
* **Regional Profitability:** Isolated states where high sales volume does not correlate with high-profit margins, highlighting operational inefficiencies.
* **Product Optimization:** Highlighted the Top 15 Products contributing to 80% of total profit, aiding in inventory and supply chain prioritization.

## 🚀 Key Features
* **Interactive Slicers:** Deep-dive by Year, Region, and Segment.
* **Drill-Through Capability:** Seamlessly move from high-level Overview to granular Transaction details.
* **Executive UI:** Consistent use of professional color palettes (#865EFF) and high-contrast typography for maximum readability.
