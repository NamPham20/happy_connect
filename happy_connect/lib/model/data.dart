class Data {
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  String? sessionState;
  String? scope;

  Data({this.accessToken, this.expiresIn, this.refreshExpiresIn, this.refreshToken, this.tokenType, this.sessionState, this.scope});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json["access_token"];
    expiresIn = json["expires_in"];
    refreshExpiresIn = json["refresh_expires_in"];
    refreshToken = json["refresh_token"];
    tokenType = json["token_type"];
    sessionState = json["session_state"];
    scope = json["scope"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["access_token"] = accessToken;
    _data["expires_in"] = expiresIn;
    _data["refresh_expires_in"] = refreshExpiresIn;
    _data["refresh_token"] = refreshToken;
    _data["token_type"] = tokenType;
    _data["session_state"] = sessionState;
    _data["scope"] = scope;
    return _data;
  }

  @override
  String toString() {
    return 'Data{accessToken: $accessToken, expiresIn: $expiresIn, refreshExpiresIn: $refreshExpiresIn, refreshToken: $refreshToken, tokenType: $tokenType, sessionState: $sessionState, scope: $scope}';
  }
}