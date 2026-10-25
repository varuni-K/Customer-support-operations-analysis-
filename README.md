# Customer Support Operations & Performance Analysis

An end-to-end business analysis project using **Excel, SQL (MySQL) and Power BI** to find out why customer support tickets are late and what to fix first.

> **Data note:** the data is **synthetic** (created for this project). It has 4,960 tickets after cleaning, from January to August 2026. No real customer data was used.

## The business problem

A customer support team handles billing issues, cancellations, login problems and more. Customers are waiting too long for some of these requests, and management cannot see what is causing the delays.

**Questions this project answers**
- Which ticket categories have the most tickets?
- Which priorities take the longest to resolve?
- What percentage of tickets is resolved?
- Which categories miss their deadlines (SLA) most often?
- Does a longer wait lower customer satisfaction?
- What should management fix first?

## What I found

| Measure | Result |
|---|---|
| Total tickets (cleaned) | 4,960 |
| Resolution rate | 86.9% |
| Average resolution time | 33.2 hours |
| Tickets that missed their SLA | about 28% |
| Average customer rating (1 to 5) | 3.68 |

1. **Billing is the biggest problem.** It is 28% of tickets, but 49.3% of billing tickets miss their deadline. Billing causes about 49% of all missed deadlines.
2. **Critical tickets are too slow.** They take 11.8 hours on average against a 4-hour target.
3. **Slow tickets mean unhappy customers.** The average rating is 4.37 when a ticket is solved in under 24 hours and 2.17 when it takes over 48 hours.
4. **It is not about people or channels.** Agents, teams and channels all perform within a narrow range, so the delays come from the ticket type and the process.

## Dashboard

**Page 1: Overview**

![Dashboard page 1](powerbi/dashboard_page1.png)

**Page 2: SLA and customer satisfaction**

![Dashboard page 2](powerbi/dashboard_page2.png)

## What is in this repository

| Folder | What is inside |
|---|---|
| `data/` | `cleaned_tickets.csv`: the cleaned synthetic dataset |
| `excel/` | `support_tickets_analysis.xlsx`: raw data, cleaned data, PivotTables and the data quality log |
| `sql/` | `support_analysis_queries.sql`: 7 queries with comments, plus screenshots of the results |
| `powerbi/` | `support_dashboard.pbix`: the 2-page dashboard, plus screenshots |
| `business-analysis/` | `Customer_Support_Analysis_Report.pdf`: the full business analysis report |

## How I did it

1. **Excel:** removed 50 duplicate tickets, standardised category names, removed 40 rows with impossible dates, added columns for resolution hours, SLA target and SLA met, built 3 PivotTables and logged every data problem.
2. **SQL (MySQL):** loaded the data and wrote 7 queries (GROUP BY, CASE WHEN, AVG, COUNT and one JOIN). Each query answers one business question.
3. **Power BI:** built a data model with a Date table, wrote DAX measures and created a 2-page dashboard with filters for category and priority.
4. **Business analysis:** wrote down the business problem, stakeholders, assumptions, questions to ask, KPI definitions, SLA rules, findings and recommendations. See the report.

## Recommendations

1. Add a billing self-service FAQ and templated replies, and train a small billing specialist group.
2. Create a fast-track queue for Critical tickets with an alert after 2 hours.
3. Escalate any ticket that has been open for 36 hours to a team lead.
4. Review the hand-off process for Technical Fault tickets (48.8% breach rate).
5. Focus on ticket type and process, not on individual agent performance.

## Key definitions

| Term | Meaning |
|---|---|
| SLA | The promised resolution time. Assumed here: Critical 4 hours, High 24, Medium 48, Low 72. |
| SLA breach % | Share of resolved tickets that took longer than their SLA target. |
| Resolution rate | Resolved tickets divided by all tickets. |
| CSAT | Customer satisfaction score from 1 to 5. |

## How to explore the project

- **Dashboard:** open `powerbi/support_dashboard.pbix` in Power BI Desktop (Windows).
- **SQL:** load `data/cleaned_tickets.csv` into a MySQL table called `tickets` and run `sql/support_analysis_queries.sql`.
- **Excel:** open `excel/support_tickets_analysis.xlsx` in Excel or LibreOffice.

## Limitations

- The data is synthetic, so the patterns are illustrative.
- The link between slow tickets and low ratings shows an association, not proven cause.
- Open and Pending tickets have no resolution time, so they are left out of time-based measures.
- The SLA targets are assumed and would need to be confirmed with the business.
- Two KPI cards on the dashboard display rounded values (5K and 4K). The exact values are 4,960 and 4,312.

---
**Author:** Varuni K
