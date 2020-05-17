# Finale

Finals sign up application for [Westside High School](https://whs.westside66.org). Built with Next.js + Hasura.

### Roadmap

- **Login in via school website**: JWT authentication
- **Admin**:
  - Background jobs for pulling school database data
  - Upload scheduled finals mods spreadsheet
  - Parsing of finals mods spreadsheet
- **Students**:
  - Select classes with finals from db (name, room, teacher(s)/departments, capacity, mods available)
  - Must check course teacher if "Any Class" final type, or if department taught course (e.g. Physics)
  - Real-time (pub/sub) system with signups, on-click = reservation
    - Full schedules pre-compiled via scheduling algorithms
  - WHS app integration to see finals
- **Teachers**:
  - Course selection to select which classes have finals
  - Set capacity for selected finals
  - Live view of students signed up for each class each mod
  - All teachers of a department/co-taught class should be able to see signups
- **Dockerize**

