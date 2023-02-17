import SQLiteKit;

import JazzConfiguration;
import JazzDataAccess;

public final class SqliteRepositoryBuilder<TResource: Storable> {
    private var configuration: Configuration?;
    private var delegate: SqliteRepositoryDelegate<TResource>?;
    private var criterionHandlers: [CriterionHandler<TResource>] = [
        IdQueryCriterionHandler<TResource>(),
        IdsQueryCriterionHandler<TResource>()
    ];
    private var hintHandlers: [HintHandler<TResource>] = [
        MaxResultsHintHandler<TResource>(),
        PageHintHandler<TResource>()
    ];

    public init() {}

    public final func with(configuration: Configuration) -> SqliteRepositoryBuilder<TResource> {
        self.configuration = configuration;

        return self;
    }

    public final func with(delegate: SqliteRepositoryDelegate<TResource>) -> SqliteRepositoryBuilder<TResource> {
        self.delegate = delegate;

        return self;
    }

    public final func with(criterionHandler: CriterionHandler<TResource>) -> SqliteRepositoryBuilder<TResource> {
        criterionHandlers.append(criterionHandler);

        return self;
    }

    public final func with(hintHandler: HintHandler<TResource>) -> SqliteRepositoryBuilder<TResource> {
        hintHandlers.append(hintHandler);

        return self;
    }

    public final func build() async throws -> Repository<TResource> {
        if let configuration = configuration, let delegate = delegate {
            guard let _: SqliteRepositoryConfig = await configuration.fetch() else {
                throw SqliteErrors.missingConfig;
            }

            let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1);

            let connection = try await SQLiteConnectionSource(
                    configuration:SQLiteConfiguration(storage: .memory),
                    threadPool: NIOThreadPool(numberOfThreads: 1)
                )
                .makeConnection(logger: .init(label: "test"), on: eventLoopGroup as! EventLoop)
                .get();

            return SqliteRepository<TResource>(
                database: connection.sql(),
                delegate: delegate,
                criterionProcessor: CriterionProcessorImpl<TResource>(criterionHandlers: criterionHandlers),
                hintProcessor: HintProcessorImpl<TResource>(hintHandlers: hintHandlers)
            );
        }

        throw SqliteErrors.missingDependancy;
    }
}