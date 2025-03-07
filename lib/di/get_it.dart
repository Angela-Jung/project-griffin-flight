import 'package:get_it/get_it.dart';
import 'package:griffin/data/repositories/airport_repository_impl.dart';
import 'package:griffin/data/repositories/books_repository_impl.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';
import 'package:griffin/data/repositories/my_books_for_pay_repository_impl.dart';
import 'package:griffin/data/repositories/passport_repository_impl.dart';
import 'package:griffin/data/repositories/payment_repository_impl.dart';
import 'package:griffin/data/repositories/session_repository_impl.dart';
import 'package:griffin/data/repositories/sign_repository_impl.dart';
import 'package:griffin/data/repositories/user_repository_impl.dart';
import 'package:griffin/domain/repositories/airplanes_repository.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/domain/repositories/books_repository.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/domain/repositories/my_books_for_pay_repository.dart';
import 'package:griffin/domain/repositories/passport_repository.dart';
import 'package:griffin/domain/repositories/payment_repository.dart';
import 'package:griffin/domain/repositories/session_repository.dart';
import 'package:griffin/domain/repositories/sign_repository.dart';
import 'package:griffin/domain/repositories/user_repository.dart';
import 'package:griffin/domain/use_cases/airport/airport_list_use_case.dart';
import 'package:griffin/domain/use_cases/books/books_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_from_flight_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_number_of_people_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_seat_use_case.dart';
import 'package:griffin/domain/use_cases/books/get_to_flight_use_case.dart';
import 'package:griffin/domain/use_cases/my_books/my_books_for_pay_use_case.dart';
import 'package:griffin/domain/use_cases/my_books/total_my_books_use_case.dart';
import 'package:griffin/domain/use_cases/passport/passport_use_case.dart';
import 'package:griffin/domain/use_cases/search/reset_flight_result_use_case.dart';
import 'package:griffin/domain/use_cases/search/save_flight_result_use_case.dart';
import 'package:griffin/domain/use_cases/search/save_number_of_people_use_case.dart';
import 'package:griffin/domain/use_cases/search/save_seat_class_use_case.dart';
import 'package:griffin/domain/use_cases/search/search_flight_use_case.dart';
import 'package:griffin/domain/use_cases/sign/save_session_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_up_use_case.dart';
import 'package:griffin/domain/use_cases/splash/get_session_use_case.dart';
import 'package:griffin/domain/use_cases/splash/splash_get_user_info_use_case.dart';
import 'package:griffin/presentation/book/books/books_view_model.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/my_books/my_books_view_model.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:griffin/presentation/pay/pay_view_model.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_view_model.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';

import '../data/repositories/airplanes_repository_impl.dart';
import '../data/repositories/seat_repository_impl.dart';
import '../domain/repositories/seat_repository.dart';
import '../domain/use_cases/airplanes/airplanes_use_case.dart';
import '../domain/use_cases/payment/get_pay_data_use_case.dart';
import '../domain/use_cases/payment/post_pay_data_use_case.dart';
import '../domain/use_cases/seat/seat_use_case.dart';
import '../domain/use_cases/sign/delete_session_use_case.dart';
import '../presentation/book/seat/seat_view_model.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // repository
  getIt
    ..registerSingleton<SessionRepository>(
      SessionRepositoryImpl(),
    )
    ..registerSingleton<UserRepository>(
      UserRepositoryImpl(),
    )
    ..registerSingleton<SignRepository>(
      SignRepositoryImpl(),
    )
    ..registerSingleton<MyBooksForPayRepository>(
      MyBooksForPayRepositoryImpl(),
    )
    ..registerSingleton<AirportRepository>(
      AirportRepositoryImpl(),
    )
    ..registerSingleton<FlightRepository>(
      FlightRepositoryImpl(),
    )
    ..registerSingleton<PassportRepository>(
      PassportRepositoryImpl(),
    )
    ..registerSingleton<BooksRepository>(
      BooksRepositoryImpl(),
    )
    ..registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(),
    )
    ..registerSingleton<SeatRepository>(
      SeatRepositoryImpl(),
    )
    ..registerSingleton<AirplanesRepository>(
      AirplanesRepositoryImpl(),
    );

  // use case
  getIt
    ..registerSingleton<GetSessionUseCase>(
      GetSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<SaveSessionUseCase>(
      SaveSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<DeleteSessionUseCase>(
      DeleteSessionUseCase(
        sessionRepository: getIt<SessionRepository>(),
      ),
    )
    ..registerSingleton<SignUpUseCase>(
      SignUpUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<SignInUseCase>(
      SignInUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<SignOutUseCase>(
      SignOutUseCase(
        signRepository: getIt<SignRepository>(),
      ),
    )
    ..registerSingleton<GetUserInfoUseCase>(
      GetUserInfoUseCase(
        userRepository: getIt<UserRepository>(),
      ),
    )
    ..registerSingleton<AirportListUseCase>(
      AirportListUseCase(
        airportRepository: getIt<AirportRepository>(),
      ),
    )
    ..registerSingleton<SearchFlightUseCase>(
      SearchFlightUseCase(
        flightRepository: getIt<FlightRepository>(),
        airportRepository: getIt<AirportRepository>(),
      ),
    )
    ..registerSingleton<ResetFlightResultUseCase>(
      ResetFlightResultUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<SaveSeatClassUseCase>(
      SaveSeatClassUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<SaveNumberOfPeopleUseCase>(
      SaveNumberOfPeopleUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<SeatUseCase>(
      SeatUseCase(
        seatRepository: getIt<SeatRepository>(),
      ),
    )

    ..registerSingleton<GetToFlightUseCase>(
      GetToFlightUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<GetFromFlightUseCase>(
      GetFromFlightUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<GetNumberOfPeopleUseCase>(
      GetNumberOfPeopleUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<GetSeatUseCase>(
      GetSeatUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<PassportUsecase>(
      PassportUsecase(
        passportRepository: getIt<PassportRepository>(),
      ),
    )
    ..registerSingleton<MyBooksForPayUseCase>(
      MyBooksForPayUseCase(
        myBooksForPayRepository: getIt<MyBooksForPayRepository>(),
      ),
    )
    ..registerSingleton<TotalMyBooksUseCase>(
      TotalMyBooksUseCase(
        booksRepository: getIt<BooksRepository>(),
      ),
    )
    ..registerSingleton<PostPayDataUseCase>(
      PostPayDataUseCase(
        paymentRepository: getIt<PaymentRepository>(),
      ),
    )
    ..registerSingleton<BooksUseCase>(
      BooksUseCase(booksRepository: getIt<BooksRepository>()),
    )
    ..registerSingleton<GetPayDataUseCase>(
      GetPayDataUseCase(
        paymentRepository: getIt<PaymentRepository>(),
      ),
    )
    ..registerSingleton<SaveFlightResultUseCase>(
      SaveFlightResultUseCase(
        flightRepository: getIt<FlightRepository>(),
      ),
    )
    ..registerSingleton<AirplanesUseCase>(
      AirplanesUseCase(
        airplanesRepository: getIt<AirplanesRepository>(),
      ),
    );

  // view models
  getIt
    ..registerFactory<SearchViewModel>(
      () => SearchViewModel(
        getSessionUseCase: getIt<GetSessionUseCase>(),
        airportListUseCase: getIt<AirportListUseCase>(),
        searchFlightUseCase: getIt<SearchFlightUseCase>(),
        resetFlightResultUseCase: getIt<ResetFlightResultUseCase>(),
        saveSeatClassUseCase: getIt<SaveSeatClassUseCase>(),
        saveNumberOfPeopleUseCase: getIt<SaveNumberOfPeopleUseCase>(),
      ),
    )
    ..registerFactory<FlightResultViewModel>(
      () => FlightResultViewModel(
        saveFlightResultUseCase: getIt<SaveFlightResultUseCase>(),
      ),
    )
    ..registerFactory<SplashViewModel>(
      () => SplashViewModel(
        getSessionUseCase: getIt<GetSessionUseCase>(),
        getUserInfoUseCase: getIt<GetUserInfoUseCase>(),
      ),
    )
    ..registerFactory<SignViewModel>(
      () => SignViewModel(
        signUpUseCase: getIt<SignUpUseCase>(),
        signInUseCase: getIt<SignInUseCase>(),
        saveSessionUseCase: getIt<SaveSessionUseCase>(),
      ),
    )
    ..registerFactory<MypageViewModel>(
      () => MypageViewModel(
        deleteSessionUseCase: getIt<DeleteSessionUseCase>(),
        signOutUseCase: getIt<SignOutUseCase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
        myBooksUseCase: getIt<MyBooksForPayUseCase>(),
      ),
    )
    ..registerFactory<MyBooksViewModel>(
      () => MyBooksViewModel(
        myBooksUseCase: getIt<MyBooksForPayUseCase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
        postPayDataUseCase: getIt<PostPayDataUseCase>(),
      ),
    )
    ..registerFactory<BooksViewModel>(
      () => BooksViewModel(
        booksUseCase: getIt<BooksUseCase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
        getFromFlightUseCase: getIt<GetFromFlightUseCase>(),
        getToFlightUseCase: getIt<GetToFlightUseCase>(),
        getNumberOfPeopleUseCase: getIt<GetNumberOfPeopleUseCase>(),
        getSeatUseCase: getIt<GetSeatUseCase>(),
      ),
    )
    ..registerFactory<PassportViewModel>(
      () => PassportViewModel(
        passportUsecase: getIt<PassportUsecase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
      ),
    )
    ..registerFactory<PayViewModel>(
      () => PayViewModel(
        totalMyBooksUseCase: getIt<TotalMyBooksUseCase>(),
        postPayDataUseCase: getIt<PostPayDataUseCase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
        getPayDataUseCase: getIt<GetPayDataUseCase>(),
      ),
    )
    ..registerFactory<SeatViewModel>(
      () => SeatViewModel(
        seatUseCase: getIt<SeatUseCase>(),
        getSessionUseCase: getIt<GetSessionUseCase>(),
        airplanesUseCase: getIt<AirplanesUseCase>(),
      ),
    )
  ;
}
