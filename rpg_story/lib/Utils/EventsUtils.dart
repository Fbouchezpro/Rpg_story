enum EventCategory {
  none,
  starWarsShatterpoint,
  starWarsLegion,
  starWarsXWing,
  marvelCrisisProtocol,
}

String getCategoryString(EventCategory category) {
  switch (category) {
    case EventCategory.none:
      return "No category";
    case EventCategory.marvelCrisisProtocol:
      return "Marvel Crisis Protocol";
    case EventCategory.starWarsLegion:
      return "Star Wars Legion";
    case EventCategory.starWarsShatterpoint:
      return "Star Wars Shatterpoint";
    case EventCategory.starWarsXWing:
      return "Star Wars X-Wing";
  }
}

EventCategory getCategoryFromUUID(String uuid) {
  if (uuid == '82b4e705-9ca7-4810-8078-01cfa45ba9f6') {
    return EventCategory.marvelCrisisProtocol;
  } else if (uuid == '7cc30c1c-f7c1-4d4b-a4d7-8e3b0166d859') {
    return EventCategory.starWarsLegion;
  } else if (uuid == '265210b3-a7c8-4e26-8bdc-d3606dc9a16d') {
    return EventCategory.starWarsShatterpoint;
  } else if (uuid == '17ac0cb6-c386-45b6-9e93-0facb5aa59c7') {
    return EventCategory.starWarsXWing;
  }

  return EventCategory.none;
}

String getUUIDFromCategory(EventCategory category) {
  switch (category) {
    case EventCategory.marvelCrisisProtocol:
      return '82b4e705-9ca7-4810-8078-01cfa45ba9f6';
    case EventCategory.starWarsLegion:
      return '7cc30c1c-f7c1-4d4b-a4d7-8e3b0166d859';
    case EventCategory.starWarsShatterpoint:
      return '265210b3-a7c8-4e26-8bdc-d3606dc9a16d';
    case EventCategory.starWarsXWing:
      return '17ac0cb6-c386-45b6-9e93-0facb5aa59c7';
    default:
      return '4fae7f93-b37a-435b-9707-c8b68f243b76';
  }
}

String getCategoryImage(EventCategory category) {
  switch (category) {
    case EventCategory.none:
      return "assets/meeple_logo.png";
    case EventCategory.marvelCrisisProtocol:
      return "assets/marvel_crisis_protocol_logo.png";
    case EventCategory.starWarsLegion:
      return "assets/sw_legion_logo.png";
    case EventCategory.starWarsShatterpoint:
      return "assets/sw_shatterpoint_logo.png";
    case EventCategory.starWarsXWing:
      return "assets/sw_x_wing_logo.png";
  }
}
