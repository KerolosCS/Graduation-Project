part of 'getvideo_cubit.dart';


sealed class GetvideoState {}

final class GetvideoSucces extends GetvideoState {}

final class GetvideoFail extends GetvideoState {}
final class ChangeView extends GetvideoState {}
