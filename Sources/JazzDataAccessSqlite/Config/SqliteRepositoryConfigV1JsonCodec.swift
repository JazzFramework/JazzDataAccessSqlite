import JazzCodec;

internal final class SqliteRepositoryConfigV1JsonCodec: JsonCodec<SqliteRepositoryConfig> {
    internal static let supportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "sqlite.config",
                "version": "1"
            ]
        );

    public override func getSupportedMediaType() -> MediaType {
        return SqliteRepositoryConfigV1JsonCodec.supportedMediaType;
    }

    public override func encodeJson(data: SqliteRepositoryConfig) async -> JsonObject {
        return JsonObjectBuilder().build();
    }

    public override func decodeJson(data: JsonObject) async -> SqliteRepositoryConfig? {
        return SqliteRepositoryConfig();
    }
}