





enum ePingTargetType {
  None,
  GateWay,
  Wan;

  String get str => this.toString().split('.').last;

  static ePingTargetType getPingTargetType(String str) {

    for (ePingTargetType type in ePingTargetType.values)
    {
      if (type.str.toLowerCase() == str.toLowerCase())
      {
        return type;
      }
    }

    return ePingTargetType.None;

  }

}
