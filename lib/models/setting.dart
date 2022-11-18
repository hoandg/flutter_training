class Setting {
  late int smallBlind;
  late int bigBlind;
  late double playerTimer;
  late double blindTimer;

  Setting(this.smallBlind, this.bigBlind, this.playerTimer, this.blindTimer);

  Setting.init();

  Setting.defaultConstructor() {
    smallBlind = 1;
    bigBlind = 2;
    playerTimer = 0.5;
    blindTimer = 30;
  }

  void setSmallBlind(int smallBlind) {
    this.smallBlind = smallBlind;
  }

  void setBigBlind(int bigBlind) {
    this.bigBlind = bigBlind;
  }

  void setPlayerTimer(double playerTimer) {
    this.playerTimer = playerTimer;
  }

  void setBlindTimer(double blindTimer) {
    this.blindTimer = blindTimer;
  }

  @override
  String toString() {
    return "$smallBlind, $bigBlind, $playerTimer, $blindTimer";
  }

  Map<String, dynamic> toJson() => {
        'smallBlind': smallBlind,
        'bigBlind': bigBlind,
        'playerTimer': playerTimer,
        'blindTimer': blindTimer,
      };

  Setting.fromJson(Map<String, dynamic> json)
      : smallBlind = json['smallBlind'],
        bigBlind = json['bigBlind'],
        playerTimer = json['playerTimer'],
        blindTimer = json['blindTimer'];
}
