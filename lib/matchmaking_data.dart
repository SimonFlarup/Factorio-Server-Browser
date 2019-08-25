class GetGame {
  final int gameId;
  final String name;
  final String description;
  final int maxPlayers;
  final List<String> players;
  final ApplicationVersion appVersion;
  final int gameTimeElapsed;
  final bool hasPassword;
  final String serverId;
  final List<String> tags;
  final bool hasMods;
  final int modCount;

  GetGame({this.gameId, this.name, this.description, this.maxPlayers, this.players, this.appVersion, this.gameTimeElapsed, this.hasPassword, this.serverId, this.tags, this.hasMods, this.modCount});

  factory GetGame.fromJson(Map<String, dynamic> json) {
    var _players = json['players'] as List;
    _players = _players.map((player) => player as String).toList();
    var _appVersion = ApplicationVersion.fromJson(json['application_version']);
    var _gameTimeElapsed = int.parse(json['game_time_elapsed']);
    return GetGame(
      gameId: json['game_id'],
      name: json['name'],
      description: json['description'],
      maxPlayers: json['max_players'] as int,
      players: _players,
      appVersion: _appVersion,
      gameTimeElapsed: _gameTimeElapsed,
      hasPassword: json['has_password'] as bool,
      serverId: json['server_id'],
      hasMods: json['has_mods'] as bool,
      modCount: json['mod_count'] as int,
    );

}
}

class ApplicationVersion {
  final String gameVersion;
  final int buildVersion;
  final String buildMode;
  final String platform;

  ApplicationVersion({this.gameVersion, this.buildVersion, this.buildMode, this.platform});

  factory ApplicationVersion.fromJson(Map<String, dynamic> json) {
    return ApplicationVersion(
      gameVersion: json['game_version'],
      buildVersion: json['build_version'] as int,
      buildMode: json['build_mode'],
      platform: json['platform'],
    );
  }
}

class GetGameDetail extends GetGame {
  final String hostAddress;
  final double lastHeartbeat;
  final List<Mods> mods;
  final String modsCrc;

  GetGameDetail({this.hostAddress, this.lastHeartbeat, this.mods, this.modsCrc});
}

class Mods {
  final String name;
  final String version;

  Mods(this.name, this.version);
}