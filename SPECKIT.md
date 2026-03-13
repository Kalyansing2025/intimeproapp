# InTimePro — SpecKit Specification Document
## Spec-It Driven Development (SIDD)

---

## 1. Project Overview

| Field | Details |
|---|---|
| **Project Name** | InTimePro |
| **Type** | Mobile Application (Flutter) |
| **Team** | Team 9 |
| **Event** | SpecKit Bootcamp — March 14, 2026 |
| **Methodology** | Spec-It Driven Development (SpecKit) |

### Team Members

| # | Name | Role |
|---|---|---|
| 1 | Ravindra Kawale | Team Lead / Backend Spec |
| 2 | Nitin Sonawane | Frontend Spec / UI Design |
| 3 | Kalyansing Chanda | Flutter Developer / Spec Writer |
| 4 | Prasad Deshmukh | Data Model Spec |
| 5 | Jaykumar Sukhdane | QA / Test Case Spec |

---

## 2. Problem Statement

> **Employees in organizations struggle to track their daily work time, manage tasks, apply for leaves, and stay updated with project progress — all from one place.**

### Pain Points Identified:
- Employees forget to log their work hours daily
- Leave applications are done via email — no tracking
- Project progress is not visible to team members
- Managers cannot see real-time task status
- No centralized notification system for work updates

### Solution:
**InTimePro** — A mobile productivity app that provides:
- One-tap time tracking with live timer
- Task & project visibility in real time
- Easy digital leave application & approval tracking
- Timesheet management with weekly view
- Centralized push notifications

---

## 3. Spec-It Driven Development (SIDD) Process

```
SPEC  →  DESIGN  →  CODE  →  TEST  →  DELIVER
 ↑                                        |
 └──────── feedback loop ─────────────────┘
```

### How SpecKit was applied to InTimePro:

1. **SPEC PHASE**: Each module was broken into Feature Requirements (FR-XXX-001)
2. **DESIGN PHASE**: Figma wireframes matched to each FR
3. **CODE PHASE**: Each Flutter screen implements the FR (with comment reference)
4. **TEST PHASE**: Acceptance Criteria verified per FR
5. **DELIVER**: Working app + this spec document

---

## 4. Module Specifications

---

### MODULE 1: Authentication
**Module Code:** `AUTH`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-AUTH-001 | User shall be able to login with Email & Password | Login succeeds with valid credentials | P1 | ✅ Done |
| FR-AUTH-002 | System shall validate email format | Invalid email shows error message | P1 | ✅ Done |
| FR-AUTH-003 | System shall validate password is not empty | Empty password shows error message | P1 | ✅ Done |
| FR-AUTH-004 | User shall have "Remember Me" option | Checkbox remembers login state | P2 | ✅ Done |
| FR-AUTH-005 | User shall be able to login via Microsoft SSO | Microsoft SSO button visible and clickable | P2 | ✅ Done |
| FR-AUTH-006 | User shall be able to login via Google SSO | Google SSO button visible and clickable | P2 | ✅ Done |
| FR-AUTH-007 | User shall see "Forgot Password?" option | Tapping shows forgot password flow | P2 | ✅ Done |

**Linked Code:** `lib/screens/auth/login_screen.dart`

---

### MODULE 2: Home / Dashboard
**Module Code:** `HOME`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-HOME-001 | User shall see their name, role & online status on dashboard | Profile info visible at top of screen | P1 | ✅ Done |
| FR-HOME-002 | System shall display a live running timer for active task | Timer updates every second | P1 | ✅ Done |
| FR-HOME-003 | User shall see Check-in time | Check-in time shown on dashboard | P1 | ✅ Done |
| FR-HOME-004 | System shall display Active Time & Work Time stats | Stats chips show correct durations | P1 | ✅ Done |
| FR-HOME-005 | User shall see tasks filtered by status tabs | 4 tabs: All, New, In Progress, Overdue | P1 | ✅ Done |
| FR-HOME-006 | User shall be able to Start/Pause active task timer | Start and Pause buttons visible on task card | P1 | ✅ Done |

**Linked Code:** `lib/screens/home/home_screen.dart`

---

### MODULE 3: Task Management (Activities)
**Module Code:** `TASK`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-TASK-001 | User shall see all tasks in a list | All tasks displayed with title and project | P1 | ✅ Done |
| FR-TASK-002 | System shall show task status visually | Color indicators for New/InProgress/Overdue/Done | P1 | ✅ Done |
| FR-TASK-003 | User shall be able to search tasks | Search bar filters tasks by name | P2 | ✅ Done |
| FR-TASK-004 | System shall show billable/non-billable indicator | Billable badge visible on each task | P2 | ✅ Done |
| FR-TASK-005 | System shall show elapsed time per task | Time counter shown on active tasks | P1 | ✅ Done |

**Linked Code:** `lib/screens/activities/activities_screen.dart`, `lib/widgets/task_card.dart`

---

### MODULE 4: Project Management
**Module Code:** `PROJ`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-PROJ-001 | User shall see list of all projects | Projects listed with name and client | P1 | ✅ Done |
| FR-PROJ-002 | System shall display project completion percentage | Progress bar shows % completed | P1 | ✅ Done |
| FR-PROJ-003 | System shall display project start and end dates | Dates visible in project card | P1 | ✅ Done |
| FR-PROJ-004 | System shall display team members per project | Team member avatars shown | P2 | ✅ Done |

**Linked Code:** `lib/screens/projects/projects_screen.dart`

---

### MODULE 5: Timesheet Management
**Module Code:** `TIME`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-TIME-001 | User shall see weekly timesheet view | Week strip calendar with day selection | P1 | ✅ Done |
| FR-TIME-002 | User shall see time entries per day | Time logs listed for selected day | P1 | ✅ Done |
| FR-TIME-003 | System shall display total hours per entry | Duration shown for each entry | P1 | ✅ Done |
| FR-TIME-004 | User shall toggle between My Timesheet & Submitted | Toggle button switches view | P2 | ✅ Done |
| FR-TIME-005 | System shall show billable status per entry | Billable/Non-billable shown per entry | P2 | ✅ Done |

**Linked Code:** `lib/screens/timesheet/timesheet_screen.dart`

---

### MODULE 6: Leave Management
**Module Code:** `LEAVE`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-LEAVE-001 | User shall see list of all leave requests | Leave list shows type, date, status | P1 | ✅ Done |
| FR-LEAVE-002 | System shall show leave status visually | Color-coded: Approved/Pending/Rejected | P1 | ✅ Done |
| FR-LEAVE-003 | User shall be able to apply for a new leave | "Apply Leave" button opens form | P1 | ✅ Done |
| FR-LEAVE-004 | User shall select leave type from dropdown | Vacation, Casual, Sick, Parental options | P1 | ✅ Done |
| FR-LEAVE-005 | User shall select leave date range | Date range picker for from/to dates | P1 | ✅ Done |

**Linked Code:** `lib/screens/leaves/leaves_screen.dart`

---

### MODULE 7: Notifications
**Module Code:** `NOTIF`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-NOTIF-001 | User shall see list of all notifications | All notifications listed chronologically | P1 | ✅ Done |
| FR-NOTIF-002 | System shall distinguish unread notifications | Unread notifications visually highlighted | P1 | ✅ Done |
| FR-NOTIF-003 | System shall show notification type icon | Icons differ per type (task, leave, system) | P2 | ✅ Done |
| FR-NOTIF-004 | System shall show notification timestamp | Time/date visible per notification | P1 | ✅ Done |

**Linked Code:** `lib/screens/notifications/notifications_screen.dart`

---

### MODULE 8: Settings
**Module Code:** `SET`

| Spec ID | Feature Requirement | Acceptance Criteria | Priority | Status |
|---|---|---|---|---|
| FR-SET-001 | User shall see account settings | Profile info shown in settings | P1 | ✅ Done |
| FR-SET-002 | User shall toggle notification preferences | Push/Email notification toggles work | P2 | ✅ Done |
| FR-SET-003 | User shall toggle private time mode | Private time toggle visible | P2 | ✅ Done |
| FR-SET-004 | User shall be able to logout | Logout button shown and functional | P1 | ✅ Done |

**Linked Code:** `lib/screens/settings/settings_screen.dart`

---

## 5. Technical Architecture (Spec)

```
InTimePro — Flutter App Architecture
────────────────────────────────────

┌─────────────────────────────────────────┐
│              Presentation Layer          │
│  (Screens: Login, Home, Tasks,           │
│   Projects, Timesheet, Leaves,           │
│   Notifications, Settings)              │
├─────────────────────────────────────────┤
│              Widget Layer                │
│  (Reusable: TaskCard, DarkHeader,        │
│   WeekStrip, NavItem)                   │
├─────────────────────────────────────────┤
│              State Management            │
│  (Provider pattern — ready to integrate) │
├─────────────────────────────────────────┤
│              Data / Model Layer          │
│  (Models: Task, Project, Leave,          │
│   Notification, Timesheet)              │
├─────────────────────────────────────────┤
│              Core / Constants            │
│  (AppColors, AppStrings, AppTheme)       │
└─────────────────────────────────────────┘
```

### Tech Stack Decisions (per SpecKit reasoning):

| Decision | Why |
|---|---|
| **Flutter** | Cross-platform (Android + iOS + Web) from single codebase |
| **Provider** | Lightweight state management, easy to understand |
| **Puro** | Flutter version management — consistent environment across team |
| **table_calendar** | Built-in calendar for timesheet week view |
| **percent_indicator** | Progress bars for project completion |

---

## 6. Spec Traceability Matrix

| Spec ID | Screen File | Widget/Method | Verified |
|---|---|---|---|
| FR-AUTH-001 | `login_screen.dart` | `_loginForm`, `_handleLogin()` | ✅ |
| FR-AUTH-004 | `login_screen.dart` | `_rememberMe` checkbox | ✅ |
| FR-HOME-002 | `home_screen.dart` | `_startTimer()`, `_activeElapsed` | ✅ |
| FR-HOME-005 | `home_screen.dart` | `TabController`, `TabBarView` | ✅ |
| FR-TASK-003 | `activities_screen.dart` | `_searchController`, search filter | ✅ |
| FR-PROJ-002 | `projects_screen.dart` | `LinearProgressIndicator` | ✅ |
| FR-TIME-001 | `timesheet_screen.dart` | `_WeekStrip` widget | ✅ |
| FR-LEAVE-003 | `leaves_screen.dart` | `_ApplyLeaveSheet` bottom sheet | ✅ |
| FR-LEAVE-005 | `leaves_screen.dart` | `showDateRangePicker()` | ✅ |
| FR-NOTIF-002 | `notifications_screen.dart` | `isRead` property styling | ✅ |

---

## 7. SpecKit Presentation Flow (Bootcamp Demo)

### Step 1 — Problem Statement (2 min)
*"Employees struggle to track work time, leaves, and tasks from one place."*

### Step 2 — Spec Walk (3 min)
Show this SPECKIT.md → FR table → pick 3 examples (FR-AUTH-001, FR-HOME-002, FR-LEAVE-003)

### Step 3 — Live Demo (5 min)
- Open app → Login → Home (live timer) → Apply Leave → Notifications

### Step 4 — Code ↔ Spec (3 min)
*"FR-HOME-002 says timer must update every second → show `_startTimer()` in code"*

### Step 5 — Q&A (2 min)

---

## 8. Total Count

| Metric | Count |
|---|---|
| Total Modules | 8 |
| Total Feature Requirements | 38 FR specs |
| Total Screens | 8 screens |
| Total Reusable Widgets | 4 widgets |
| Total Data Models | 5 models |
| Lines of Code (approx) | ~2,000+ |
| Priority P1 Features | 26 |
| Priority P2 Features | 12 |

---

*Document prepared for SpecKit Bootcamp — Team 9 — March 14, 2026*
