# Finale

Finals sign up application for [Westside High School](https://whs.westside66.org). Build with Ruby on Rails, Typescript + React, GraphQL, PostgreSQL and orchestrated with Kubernetes.

## Roadmap

### For Fall 2019:
  - Spreadsheet parsing for YES/NO to course having finals

### Ruby on Rails + PostgreSQL + GraphQL Backend
- **Login in via school website**: JWT authentication
- **Admin**:
  - Local db copy upload system and db rebuilding for each semester (no live read access to school db)
    - Active Job to update courses, users from SQL Server to PostgreSQL
  - Upload scheduled finals mods spreadsheet
  - Parsing of finals mods spreadsheet
- **Students**:
  - Select classes with finals from db (name, room, teacher(s)/departments, capacity, mods available)
  - Must check course teacher if "Any Class" final type, or if department taught course (e.g. Physics)
  - Real-time (pub/sub) system with signups, on-click = reservation
  - WHS app integration to see finals
- **Teachers**:
  - Course selection to select which classes have finals
  - Set capacity for selected finals
  - Live view of students signed up for each class each mod
  - All teachers of a department/co-taught class should be able to see signups
- **Dockerize**

