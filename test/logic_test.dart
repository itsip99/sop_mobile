import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/briefing.dart';
import 'package:sop_mobile/data/models/home.dart';
import 'package:sop_mobile/data/models/report.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/brief.dart';
import 'package:sop_mobile/domain/repositories/filter.dart';
import 'package:sop_mobile/domain/repositories/login.dart';
import 'package:sop_mobile/domain/repositories/report.dart';
import 'package:sop_mobile/domain/repositories/sales.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/brief/brief_bloc.dart';
import 'package:sop_mobile/presentation/state/brief/brief_event.dart';
import 'package:sop_mobile/presentation/state/brief/brief_state.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_bloc.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_event.dart';
import 'package:sop_mobile/presentation/state/leasing/leasing_state.dart';
import 'package:sop_mobile/presentation/state/login/login_bloc.dart';
import 'package:sop_mobile/presentation/state/login/login_event.dart';
import 'package:sop_mobile/presentation/state/login/login_state.dart';
import 'package:sop_mobile/presentation/state/payment/payment_bloc.dart';
import 'package:sop_mobile/presentation/state/payment/payment_event.dart';
import 'package:sop_mobile/presentation/state/payment/payment_state.dart';
import 'package:sop_mobile/presentation/state/report/report_bloc.dart';
import 'package:sop_mobile/presentation/state/report/report_event.dart';
import 'package:sop_mobile/presentation/state/report/report_state.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/state/stu/stu_bloc.dart';
import 'package:sop_mobile/presentation/state/stu/stu_event.dart';
import 'package:sop_mobile/presentation/state/stu/stu_state.dart';

import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_leasing.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_payment.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_stu.dart';

class MockBriefRepo extends Mock implements BriefRepo {}

class MockFilterRepo extends Mock implements FilterRepo {}

class MockLoginRepo extends Mock implements LoginRepo {}

class MockReportRepo extends Mock implements ReportRepo {}

class MockSalesRepo extends Mock implements SalesRepo {}

class MockStorageRepo extends Mock implements StorageRepo {}

// Fakes for Fallback Registration
class FakeStuData extends Fake implements StuData {}

class FakePaymentData extends Fake implements PaymentData {}

class FakeLeasingData extends Fake implements LeasingData {}

class FakeSalesmanData extends Fake implements SalesmanData {}

class FakeSalesModel extends Fake implements SalesModel {}

void main() {
  // Register fallback values for custom types
  setUpAll(() {
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakePaymentData());
    registerFallbackValue(FakeLeasingData());
    registerFallbackValue(FakeSalesmanData());
    registerFallbackValue(FakeSalesModel());
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakeStuData());
    registerFallbackValue(FakeStuData());
  });
  // Run the counter cubit tests
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test('initial state is an empty map', () {
      expect(counterCubit.state, isEmpty);
    });

    blocTest(
      'emits updated state when increment is called',
      build: () => counterCubit,
      act: (bloc) => bloc.increment('counter'),
      expect:
          () => [
            isA<Map<String, int>>().having(
              (state) => state['counter'],
              'counter count',
              2,
            ),
          ],
    );

    blocTest(
      'emits updated state when decrement is called',
      build: () => counterCubit,
      act: (bloc) => bloc.decrement('counter'),
      expect:
          () => [
            isA<Map<String, int>>().having(
              (state) => state['counter'],
              'counter count',
              0,
            ),
          ],
    );

    blocTest(
      'getCount returns the current state',
      build: () => counterCubit,
      act: (bloc) => bloc.getCount()['counter'],
      expect: () => [],
    );

    blocTest(
      'emits updated state when setInitial is called',
      build: () => counterCubit,
      act: (bloc) => bloc.setInitial('counter', 5),
      expect:
          () => [
            isA<Map<String, int>>().having(
              (state) => state['counter'],
              'counter count',
              5,
            ),
          ],
    );

    blocTest(
      'emits empty state when reset is called',
      build: () => counterCubit,
      act: (bloc) => bloc.reset(),
      expect: () => [{}],
    );

    blocTest(
      'emits state without the key when deleteKey is called',
      build: () {
        counterCubit.setInitial('counter', 5);
        return counterCubit;
      },
      act: (bloc) => bloc.deleteKey('counter'),
      expect:
          () => [
            isA<Map<String, int>>().having(
              (state) => state.containsKey('counter'),
              'contains key',
              false,
            ),
          ],
    );
  });

  // Run the login bloc tests
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late MockLoginRepo mockLoginRepo;
    late MockStorageRepo mockStorageRepo;

    setUp(() {
      mockLoginRepo = MockLoginRepo();
      mockStorageRepo = MockStorageRepo();
      loginBloc = LoginBloc(mockLoginRepo, mockStorageRepo);
    });

    tearDown(() {
      loginBloc.close();
    });

    test('initial state is LoginInitial', () {
      expect(loginBloc.state, isA<LoginInitial>());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginFailure] when username and password are empty and no stored credentials',
      setUp: () {
        when(
          () => mockStorageRepo.getUserCredentials(),
        ).thenAnswer((_) async => UserCredsModel(username: '', password: ''));
      },
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginButtonPressed(username: '', password: '')),
      expect:
          () => [
            isA<LoginLoading>(),
            isA<LoginFailure>().having(
              (e) => e.error,
              'error',
              'Username or password cannot be empty',
            ),
          ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginInitial, LogoutSuccess] when logout is successful',
      setUp: () {
        when(
          () => mockStorageRepo.deleteUserCredentials(),
        ).thenAnswer((_) async {});
      },
      build: () => loginBloc,
      act: (bloc) => bloc.add(LogoutButtonPressed()),
      expect:
          () => [
            isA<LoginLoading>(),
            isA<LoginInitial>(),
            isA<LogoutSuccess>(),
          ],
      verify: (_) {
        verify(() => mockStorageRepo.deleteUserCredentials()).called(1);
      },
    );
  });

  // Run the Date cubit tests
  group('DateCubit', () {
    late DateCubit dateCubit;

    setUp(() {
      dateCubit = DateCubit();
    });

    tearDown(() {
      dateCubit.close();
    });

    test('initial state is today\'s date', () {
      expect(
        dateCubit.state,
        Formatter.dateFormatter(DateTime.now().toString().split(' ')[0]),
      );
    });

    blocTest<DateCubit, String>(
      'emits the new date when setDate is called',
      build: () => dateCubit,
      act: (cubit) => cubit.setDate('2025-07-20'),
      expect: () => ['2025-07-20'],
    );

    test('getDate returns the current state', () {
      const date = '2025-07-20';
      dateCubit.setDate(date);
      expect(dateCubit.getDate(), date);
    });
  });

  group('SalesmanBloc', () {
    late SalesmanBloc salesmanBloc;
    late MockSalesRepo mockSalesRepo;
    late MockStorageRepo mockStorageRepo;

    setUp(() {
      mockSalesRepo = MockSalesRepo();
      mockStorageRepo = MockStorageRepo();
      salesmanBloc = SalesmanBloc(
        salesRepo: mockSalesRepo,
        storageRepo: mockStorageRepo,
      );
    });

    final tSalesmanList = [
      SalesModel(
        id: '1',
        userName: 'sales1',
        tierLevel: '1',
        userId: 'user1',
        status: 1,
      ),
      SalesModel(
        id: '2',
        userName: 'sales2',
        tierLevel: '2',
        userId: 'user2',
        status: 1,
      ),
    ];
    final tSalesmanDataList =
        tSalesmanList
            .map((e) => SalesmanData(e.userName, e.tierLevel, 0, 0, 0))
            .toList();
    final tUserCreds = UserCredsModel(
      username: 'testuser',
      password: 'password',
    );

    test('initial state is SalesmanInitial', () {
      expect(salesmanBloc.state, SalesmanInitial([], [], []));
    });

    group('FetchSalesman', () {
      blocTest<SalesmanBloc, SalesmanState>(
        'emits [SalesmanLoading, SalesmanFetched] when successful',
        setUp: () {
          when(
            () => mockStorageRepo.getUserCredentials(),
          ).thenAnswer((_) async => tUserCreds);
          when(() => mockSalesRepo.fetchSalesman(any())).thenAnswer(
            (_) async => {'status': 'success', 'data': tSalesmanList},
          );
        },
        build: () => salesmanBloc,
        act: (bloc) => bloc.add(FetchSalesman()),
        expect:
            () => [
              SalesmanLoading(SalesmanInitial([], [], [])),
              isA<SalesmanFetched>()
                  .having(
                    (s) => s.fetchSalesList,
                    'fetchSalesList',
                    tSalesmanList,
                  )
                  .having(
                    (s) => s.salesDataList.length,
                    'salesDataList length',
                    tSalesmanDataList.length,
                  ),
            ],
      );

      blocTest<SalesmanBloc, SalesmanState>(
        'emits [SalesmanLoading, SalesmanError] when user credentials not found',
        setUp: () {
          when(
            () => mockStorageRepo.getUserCredentials(),
          ).thenAnswer((_) async => UserCredsModel(username: '', password: ''));
        },
        build: () => salesmanBloc,
        act: (bloc) => bloc.add(FetchSalesman()),
        expect:
            () => [
              SalesmanLoading(SalesmanInitial([], [], [])),
              SalesmanError('User credentials not found'),
            ],
      );

      blocTest<SalesmanBloc, SalesmanState>(
        'emits [SalesmanLoading, SalesmanError] when repository returns an error status',
        setUp: () {
          when(
            () => mockStorageRepo.getUserCredentials(),
          ).thenAnswer((_) async => tUserCreds);
          when(() => mockSalesRepo.fetchSalesman(any())).thenAnswer(
            (_) async => {'status': 'error', 'data': 'Something went wrong'},
          );
        },
        build: () => salesmanBloc,
        act: (bloc) => bloc.add(FetchSalesman()),
        expect:
            () => [
              SalesmanLoading(SalesmanInitial([], [], [])),
              SalesmanError('Something went wrong'),
            ],
      );
    });

    group('AddSalesman', () {
      blocTest<SalesmanBloc, SalesmanState>(
        'emits [SalesmanLoading, SalesmanAdded] when successful',
        setUp: () {
          when(
            () => mockStorageRepo.getUserCredentials(),
          ).thenAnswer((_) async => tUserCreds);
          when(
            () => mockSalesRepo.addSalesman(any(), any(), any(), any(), any()),
          ).thenAnswer((_) async => {'status': 'success'});
        },
        build: () => salesmanBloc,
        act: (bloc) => bloc.add(AddSalesman('3', 'sales3', '3', 1)),
        expect:
            () => [
              SalesmanLoading(SalesmanInitial([], [], [])),
              SalesmanAdded(),
            ],
      );
    });

    group('ModifySalesman', () {
      final initialState = SalesmanFetched(
        SalesmanInitial([], [], []),
        tSalesmanList,
        tSalesmanDataList,
      );

      blocTest<SalesmanBloc, SalesmanState>(
        'emits [SalesmanModified] with updated data',
        build: () => salesmanBloc,
        seed: () => initialState,
        act: (bloc) => bloc.add(ModifySalesman(rowIndex: 0, newSpkValue: 10)),
        expect:
            () => [
              isA<SalesmanModified>().having(
                (s) => s.salesDataList[0].spk,
                'updated spk value',
                10,
              ),
            ],
      );
    });
  });

  group('StuBloc', () {
    late StuBloc stuBloc;

    setUp(() {
      stuBloc = StuBloc();
    });

    test('initial state is StuInitial with an empty data list', () {
      // The StuBloc constructor calls super(StuInitial([])),
      // so the very first state should be StuInitial with an empty list.
      expect(stuBloc.state, isA<StuInitial>());
      expect(stuBloc.state.data, isEmpty);
    });

    blocTest<StuBloc, StuState>(
      'emits [StuInitial] when ResetStuData is added',
      build: () => stuBloc,
      act: (bloc) => bloc.add(ResetStuData()),
      expect:
          () => [
            isA<StuInitial>()
                .having((s) => s.data.length, 'data length', 3)
                .having((s) => s.data[0].type, 'item 0 type', 'MAXI'),
          ],
    );

    group('Modify Events', () {
      final seedState = StuInitial([
        StuData('MAXI', 10, 20, '50.0', 5, '200.0'),
      ]);

      blocTest<StuBloc, StuState>(
        'ModifyStuData emits [StuDataModified] with correctly calculated rates',
        build: () => stuBloc,
        seed: () => seedState,
        act:
            (bloc) => bloc.add(
              ModifyStuData(
                rowIndex: 0,
                newResultValue: 15,
                newTargetValue: 25,
                newLmValue: 10,
              ),
            ),
        expect:
            () => [
              isA<StuDataModified>()
                  .having((s) => s.data.first.result, 'result', 15)
                  .having((s) => s.data.first.target, 'target', 25)
                  .having((s) => s.data.first.lm, 'lm', 10)
                  .having((s) => s.data.first.growth, 'growth', '150.0'),
            ],
      );

      blocTest<StuBloc, StuState>(
        'ModifyStuTargetData emits [StuDataModified] with updated target',
        build: () => stuBloc,
        seed: () => seedState,
        act:
            (bloc) =>
                bloc.add(ModifyStuTargetData(rowIndex: 0, newTargetValue: 40)),
        expect:
            () => [
              isA<StuDataModified>().having(
                (s) => s.data.first.target,
                'target',
                40,
              ),
            ],
      );

      blocTest<StuBloc, StuState>(
        'ModifyStuLmData emits [StuDataModified] with updated lm and growth rate',
        build: () => stuBloc,
        seed: () => seedState,
        act: (bloc) => bloc.add(ModifyStuLmData(rowIndex: 0, newLmValue: 8)),
        expect:
            () => [
              isA<StuDataModified>()
                  .having((s) => s.data.first.lm, 'lm', 8)
                  .having((s) => s.data.first.growth, 'growth', '125.0'),
            ],
      );
    });
  });

  // Run the Filter bloc tests
  group('FilterBloc', () {
    late MockFilterRepo mockFilterRepo;
    late FilterBloc filterBloc;
    final mockReport = ReportModel.fromJson({
      'TransDate': '2025-06-20',
      'CustomerID': 'testuser',
      'CName': 'Test User',
      'Area': 'Test Area',
      'PIC': 'Test PIC',
      'DataPayment': [
        {
          'Payment': 'Cash',
          'ResultPayment': 10,
          'LMPayment': 5,
          'FlagPayment': 1,
          'LinePayment': 1,
        },
      ],
      'DataSalesman': [
        {
          'KTP': '12345',
          'Name': 'John Doe',
          'EntryLevel': 'Senior',
          'SPK': 5,
          'STU': 3,
          'STULM': 2,
          'LineSalesman': 1,
          'FlagSalesman': 1,
        },
      ],
      'DataSTU': [
        {
          'MotorGroup': 'Matic',
          'ResultSTU': 10,
          'TargetSTU': 15,
          'LMSTU': 8,
          'LineSTU': 1,
          'FlagSTU': 1,
        },
      ],
      'DataLeasing': [
        {
          'Leasing': 'FIF',
          'OpenSPK': 5,
          'ApprovedSPK': 4,
          'RejectedSPK': 1,
          'LineLeasing': 1,
          'FlagLeasing': 1,
        },
      ],
    });
    final mockBriefing = BriefingModel.fromJson({
      'TransDate': '2025-06-21',
      'Lokasi': 'Test Location',
      'Peserta': 5,
      'SM': 1,
      'SC': 2,
      'Salesman': 2,
      'Other': 0,
      'Topic': 'Test Topic',
    });

    setUp(() {
      mockFilterRepo = MockFilterRepo();
      filterBloc = FilterBloc(filterRepo: mockFilterRepo);
    });

    tearDown(() {
      filterBloc.close();
    });

    test('initial state is FilterInitial with briefing filter active', () {
      expect(filterBloc.state, isA<FilterInitial>());
      expect(filterBloc.state.activeFilter, [FilterType.briefing]);
    });

    blocTest<FilterBloc, FilterState>(
      'emits [FilterState, FilterLoading, FilterSuccess] when adding a filter successfully',
      setUp: () {
        when(
          () => mockFilterRepo.dataPreprocessing(any(), any(), any()),
        ).thenAnswer(
          (_) async => HomeModel(
            briefingData: [],
            reportData: [mockReport],
            salesData: [],
          ),
        );
      },
      build: () => filterBloc,
      act: (bloc) => bloc.add(FilterAdded(FilterType.report, '2025-06-20')),
      expect:
          () => [
            isA<FilterState>().having((s) => s.activeFilter, 'activeFilter', [
              FilterType.briefing,
              FilterType.report,
            ]),
            isA<FilterLoading>(),
            isA<FilterSuccess>(),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterState, FilterLoading, FilterError] when no data is found',
      setUp: () {
        when(
          () => mockFilterRepo.dataPreprocessing(any(), any(), any()),
        ).thenAnswer(
          (_) async =>
              HomeModel(briefingData: [], reportData: [], salesData: []),
        );
      },
      build: () => filterBloc,
      act: (bloc) => bloc.add(FilterAdded(FilterType.report, '2025-06-20')),
      expect:
          () => [
            isA<FilterState>().having((s) => s.activeFilter, 'activeFilter', [
              FilterType.briefing,
              FilterType.report,
            ]),
            isA<FilterLoading>(),
            isA<FilterError>().having(
              (e) => e.errorMessage,
              'errorMessage',
              'No data available',
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterState, FilterLoading, FilterError] when repository throws an exception',
      setUp: () {
        when(
          () => mockFilterRepo.dataPreprocessing(any(), any(), any()),
        ).thenThrow(Exception('Network Error'));
      },
      build: () => filterBloc,
      act: (bloc) => bloc.add(FilterAdded(FilterType.report, '2025-06-20')),
      expect:
          () => [
            isA<FilterState>().having((s) => s.activeFilter, 'activeFilter', [
              FilterType.briefing,
              FilterType.report,
            ]),
            isA<FilterLoading>(),
            isA<FilterError>(),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterState, FilterLoading, FilterSuccess] when removing a filter',
      setUp: () {
        when(
          () => mockFilterRepo.dataPreprocessing(any(), any(), any()),
        ).thenAnswer(
          (_) async =>
              HomeModel(briefingData: [], reportData: [], salesData: []),
        );
      },
      build: () => filterBloc,
      act: (bloc) => bloc.add(FilterRemoved(FilterType.briefing, '2025-06-20')),
      expect:
          () => [
            isA<FilterState>().having(
              (s) => s.activeFilter,
              'activeFilter',
              [],
            ),
            isA<FilterLoading>(),
            isA<FilterError>().having(
              (e) => e.errorMessage,
              'errorMessage',
              'No data available',
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits [FilterLoading, FilterSuccess] when date is modified',
      setUp: () {
        when(
          () => mockFilterRepo.dataPreprocessing(any(), any(), any()),
        ).thenAnswer(
          (_) async => HomeModel(
            briefingData: [mockBriefing],
            reportData: [],
            salesData: [],
          ),
        );
      },
      build: () => filterBloc,
      act: (bloc) => bloc.add(FilterModified('2025-06-21')),
      expect: () => [isA<FilterLoading>(), isA<FilterSuccess>()],
    );
  });

  // Run the Leasing bloc tests
  group('LeasingBloc', () {
    late LeasingBloc leasingBloc;

    setUp(() {
      leasingBloc = LeasingBloc();
    });

    tearDown(() {
      leasingBloc.close();
    });

    test(
      'initial state is LeasingInitial with 3 default leasing data entries',
      () {
        expect(leasingBloc.state, isA<LeasingInitial>());
        expect(leasingBloc.state.data.length, 3);
        expect(leasingBloc.state.data[0].type, 'BAF');
      },
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [LeasingInitial] when ResetLeasingData is added',
      build: () => leasingBloc,
      act: (bloc) => bloc.add(ResetLeasingData()),
      expect:
          () => [
            isA<LeasingInitial>().having(
              (s) => s.data.length,
              'data.length',
              3,
            ),
          ],
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [AddLeasingData] with a new row when LeasingDataAdded is added',
      build: () => leasingBloc,
      act: (bloc) => bloc.add(LeasingDataAdded()),
      expect:
          () => [
            isA<AddLeasingData>().having(
              (s) => s.data.length,
              'data.length',
              4,
            ),
          ],
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [AddLeasingData] with modified data when LeasingDataModified is added',
      build: () => leasingBloc,
      act:
          (bloc) => bloc.add(
            LeasingDataModified(
              rowIndex: 0,
              newAcceptedValue: 10,
              newRejectedValue: 5,
            ),
          ),
      expect:
          () => [
            isA<AddLeasingData>().having(
              (s) {
                final modifiedData = s.data[0];
                return modifiedData.accept == 10 &&
                    modifiedData.reject == 5 &&
                    (modifiedData.approve - (10 / 15)).abs() <
                        0.001; // Check approval rate with tolerance
              },
              'modified data',
              true,
            ),
          ],
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [AddLeasingData] with correct approval rate when only accepted value is modified',
      build: () => leasingBloc,
      act:
          (bloc) =>
              bloc.add(LeasingDataModified(rowIndex: 1, newAcceptedValue: 8)),
      expect:
          () => [
            isA<AddLeasingData>().having(
              (s) {
                final modifiedData = s.data[1];
                return modifiedData.accept == 8 &&
                    modifiedData.reject == 0 &&
                    modifiedData.approve == 1.0;
              },
              'modified data',
              true,
            ),
          ],
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [AddLeasingData] with correct approval rate when only rejected value is modified',
      build: () => leasingBloc,
      act:
          (bloc) =>
              bloc.add(LeasingDataModified(rowIndex: 2, newRejectedValue: 4)),
      expect:
          () => [
            isA<AddLeasingData>().having(
              (s) {
                final modifiedData = s.data[2];
                return modifiedData.accept == 0 &&
                    modifiedData.reject == 4 &&
                    modifiedData.approve == 0.0;
              },
              'modified data',
              true,
            ),
          ],
    );

    blocTest<LeasingBloc, LeasingState>(
      'emits [AddLeasingData] with approval rate of 0 when accepted and rejected are 0',
      build: () => leasingBloc,
      act:
          (bloc) => bloc.add(
            LeasingDataModified(
              rowIndex: 0,
              newAcceptedValue: 0,
              newRejectedValue: 0,
            ),
          ),
      expect:
          () => [
            isA<AddLeasingData>().having(
              (s) {
                final modifiedData = s.data[0];
                return modifiedData.accept == 0 &&
                    modifiedData.reject == 0 &&
                    modifiedData.approve == 0.0;
              },
              'modified data',
              true,
            ),
          ],
    );
  });

  // Run the Briefing bloc tests
  group('BriefingBloc', () {
    // Declare variables for the mock repository and the event we'll use
    late MockBriefRepo mockBriefRepo;
    // late BriefBloc briefBloc;

    // This runs before each test, setting up our variables
    setUp(() {
      mockBriefRepo = MockBriefRepo();
      // Create a standard, valid event to use in most tests
      // briefBloc = BriefBloc(briefRepo: mockBriefRepo);
    });

    // Test 1: Check the initial state of the Bloc
    test('initial state is BriefInitial', () {
      expect(BriefBloc(briefRepo: mockBriefRepo).state, isA<BriefInitial>());
    });

    // Test 2: Test the successful path
    blocTest<BriefBloc, BriefState>(
      'emits [BriefLoading, BriefCreationSuccess] when creation is successful',
      // Arrange: Set up the mock repository to return a success response
      setUp: () {
        when(
          () => mockBriefRepo.createBriefingReport(
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) async => {'status': 'success', 'data': 'Briefing Created!'},
        );
      },
      // Build: Create the BriefBloc instance with our mock repository
      build: () => BriefBloc(briefRepo: mockBriefRepo),
      // Act: Add the valid event to the Bloc
      act:
          (bloc) => bloc.add(
            BriefCreation(
              'testuser',
              'branch1',
              'shop1',
              '2025-06-19',
              'Test Location',
              5,
              1,
              2,
              2,
              0,
              'Test Description',
              'image.jpg',
            ),
          ),
      // Expect: Verify that the Bloc emits Loading, then Success
      expect: () => [isA<BriefLoading>(), isA<BriefCreationSuccess>()],
    );

    // Test 3: Test the validation failure path (e.g., empty location)
    blocTest<BriefBloc, BriefState>(
      'emits [BriefLoading, BriefCreationFail] for empty location validation',
      build: () => BriefBloc(briefRepo: mockBriefRepo),
      // Act: Add an event with an empty location string
      act:
          (bloc) => bloc.add(
            BriefCreation(
              'testuser',
              'branch1',
              'shop1',
              '2025-06-19',
              '', // Empty location
              5,
              1,
              2,
              2,
              0,
              'Test Description',
              'image.jpg',
            ),
          ),
      // Expect: Verify that the Bloc emits Loading, then Fail, and check the error message
      expect:
          () => [
            isA<BriefLoading>(),
            isA<BriefCreationFail>().having(
              (state) => state.error,
              'error',
              'Location is required.',
            ),
          ],
    );

    // Test 4: Test the repository failure path
    blocTest<BriefBloc, BriefState>(
      'emits [BriefLoading, BriefCreationFail] when repository returns fail status',
      // Arrange: Set up the mock repository to return a failure response
      setUp: () {
        when(
          () => mockBriefRepo.createBriefingReport(
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'fail', 'data': 'API Error'});
      },
      build: () => BriefBloc(briefRepo: mockBriefRepo),
      act:
          (bloc) => bloc.add(
            BriefCreation(
              'testuser',
              'branch1',
              'shop1',
              '2025-06-19',
              'Test Location',
              5,
              1,
              2,
              2,
              0,
              'Test Description',
              'image.jpg',
            ),
          ),
      // Expect: Verify that the Bloc emits Loading, then Fail
      expect: () => [isA<BriefLoading>(), isA<BriefCreationFail>()],
    );

    // Test 5: Test the exception path (e.g., network error)
    blocTest<BriefBloc, BriefState>(
      'emits [BriefLoading, BriefCreationFail] when repository throws an exception',
      // Arrange: Set up the mock repository to throw an error
      setUp: () {
        when(
          () => mockBriefRepo.createBriefingReport(
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenThrow(Exception('Network connection failed'));
      },
      build: () => BriefBloc(briefRepo: mockBriefRepo),
      act:
          (bloc) => bloc.add(
            BriefCreation(
              'testuser',
              'branch1',
              'shop1',
              '2025-06-19',
              'Test Location',
              5,
              1,
              2,
              2,
              0,
              'Test Description',
              'image.jpg',
            ),
          ),
      // Expect: Verify that the Bloc emits Loading, then Fail
      expect: () => [isA<BriefLoading>(), isA<BriefCreationFail>()],
    );
  });

  group('PaymentBloc', () {
    late PaymentBloc paymentBloc;

    setUp(() {
      paymentBloc = PaymentBloc();
    });

    tearDown(() {
      paymentBloc.close();
    });

    test('initial state is PaymentInitial with default data', () {
      expect(
        paymentBloc.state,
        PaymentInitial([
          const PaymentData('Cash', 0, 0, '0.0'),
          const PaymentData('Credit', 0, 0, '0.0'),
        ]),
      );
    });

    blocTest<PaymentBloc, PaymentState>(
      'emits [PaymentInitial] with default data when ResetPaymentData is added',
      build: () => paymentBloc,
      seed:
          () => PaymentModified([
            const PaymentData('Cash', 100, 50, '200.0'),
            const PaymentData('Credit', 0, 0, '0.0'),
          ]),
      act: (bloc) => bloc.add(ResetPaymentData()),
      expect:
          () => [
            PaymentInitial([
              const PaymentData('Cash', 0, 0, '0.0'),
              const PaymentData('Credit', 0, 0, '0.0'),
            ]),
          ],
    );

    blocTest<PaymentBloc, PaymentState>(
      'emits [PaymentModified] with updated data when PaymentDataModified is added',
      build: () => paymentBloc,
      act:
          (bloc) =>
              bloc.add(PaymentDataModified(rowIndex: 0, newResultValue: 100)),
      expect:
          () => [
            PaymentModified([
              const PaymentData('Cash', 100, 0, '0.0'),
              const PaymentData('Credit', 0, 0, '0.0'),
            ]),
          ],
    );

    blocTest<PaymentBloc, PaymentState>(
      'emits [PaymentModified] and calculates growth correctly',
      build: () => paymentBloc,
      act: (bloc) {
        bloc.add(PaymentDataModified(rowIndex: 0, newTargetValue: 50));
        bloc.add(PaymentDataModified(rowIndex: 0, newResultValue: 100));
      },
      skip: 1,
      expect:
          () => [
            PaymentModified([
              const PaymentData('Cash', 100, 50, '200.0'),
              const PaymentData('Credit', 0, 0, '0.0'),
            ]),
          ],
    );
  });

  group('ReportBloc', () {
    late ReportBloc reportBloc;
    late MockReportRepo mockReportRepo;
    late MockStorageRepo mockStorageRepo;

    setUp(() {
      mockReportRepo = MockReportRepo();
      mockStorageRepo = MockStorageRepo();
      reportBloc = ReportBloc(
        reportRepo: mockReportRepo,
        storageRepo: mockStorageRepo,
      );
    });

    tearDown(() {
      reportBloc.close();
    });

    test('initial state is ReportInitial', () {
      expect(reportBloc.state, isA<ReportInitial>());
    });

    blocTest<ReportBloc, ReportState>(
      'emits [ReportInitial] when InitiateReport is added',
      build: () => reportBloc,
      act: (bloc) => bloc.add(InitiateReport()),
      expect: () => [isA<ReportInitial>()],
    );

    blocTest<ReportBloc, ReportState>(
      'emits [ReportLoading, ReportCreationWarning] when CreateReport is added with empty fields',
      setUp: () {
        when(() => mockStorageRepo.getUserCredentials()).thenAnswer(
          (_) async =>
              UserCredsModel(username: 'testuser', password: 'password'),
        );
      },
      build: () => reportBloc,
      act:
          (bloc) => bloc.add(
            CreateReport(
              dealerName: '',
              areaName: '',
              personInCharge: '',
              stuData: [],
              paymentData: [],
              leasingData: [],
              salesmanData: [],
              salesData: [],
            ),
          ),
      expect:
          () => [
            isA<ReportLoading>(),
            isA<ReportCreationWarning>().having(
              (e) => e.message,
              'message',
              'Kolom PIC wajib diisi.',
            ),
          ],
    );

    blocTest<ReportBloc, ReportState>(
      'emits [ReportLoading, ReportCreationError] when CreateReport is added with no user credentials',
      setUp: () {
        when(
          () => mockStorageRepo.getUserCredentials(),
        ).thenAnswer((_) async => UserCredsModel(username: '', password: ''));
      },
      build: () => reportBloc,
      act:
          (bloc) => bloc.add(
            CreateReport(
              dealerName: 'test',
              areaName: 'test',
              personInCharge: 'test',
              stuData: const [],
              paymentData: const [],
              leasingData: const [],
              salesmanData: const [],
              salesData: const [],
            ),
          ),
      expect:
          () => [
            isA<ReportLoading>(),
            isA<ReportCreationError>().having(
              (e) => e.message,
              'message',
              'Informasi pengguna tidak ditemukan.',
            ),
          ],
    );

    blocTest<ReportBloc, ReportState>(
      'emits [ReportLoading, ReportCreationSuccess] when CreateReport is added successfully',
      setUp: () {
        when(() => mockStorageRepo.getUserCredentials()).thenAnswer(
          (_) async =>
              UserCredsModel(username: 'testuser', password: 'password'),
        );
        when(
          () => mockReportRepo.createBasicReport(
            any(),
            any(),
            any(),
            any(),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'success'});
        when(
          () => mockReportRepo.createReportSTU(
            any(),
            any(),
            any(that: isA<StuData>()),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'success'});
        when(
          () => mockReportRepo.createReportPayment(
            any(),
            any(),
            any(that: isA<PaymentData>()),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'success'});
        when(
          () => mockReportRepo.createReportLeasing(
            any(),
            any(),
            any(that: isA<LeasingData>()),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'success'});
        when(
          () => mockReportRepo.createReportSalesman(
            any(),
            any(),
            any(),
            any(that: isA<SalesmanData>()),
            any(),
          ),
        ).thenAnswer((_) async => {'status': 'success'});
      },
      build: () => reportBloc,
      act:
          (bloc) => bloc.add(
            CreateReport(
              dealerName: 'test',
              areaName: '00',
              personInCharge: 'John',
              stuData: [StuData('MAXI', 0, 0, '0.0', 0, '0.0')],
              paymentData: [const PaymentData('Cash', 0, 0, '0.0')],
              leasingData: [LeasingData('BAF', 0, 0, 0, 0, 0.0)],
              salesmanData: [SalesmanData('Joe', 'Gold', 0, 0, 0)],
              salesData: [
                // Ensure the userName matches the salesman's name and provide an ID
                SalesModel(
                  id: '',
                  userName: 'Joe',
                  tierLevel: 'Gold',
                  userId: '',
                  status: 1,
                ),
              ],
            ),
          ),
      expect:
          () => [
            isA<ReportLoading>(),
            isA<ReportCreationSuccess>().having(
              (e) => e.message,
              'message',
              'Laporan berhasil dibuat.',
            ),
          ],
    );
  });
}
