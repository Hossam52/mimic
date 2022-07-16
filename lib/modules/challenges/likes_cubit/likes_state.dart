part of 'likes_cubit.dart';

@immutable
abstract class LikesState {
  final bool liked;

  const LikesState(this.liked);
}

class LikesInitial extends LikesState {
 const LikesInitial(bool liked) : super(false);
}

class LikesLoading extends LikesState {
 final int videoId;
 const LikesLoading(bool liked,this.videoId) : super(liked);
}

class LikesSuccess extends LikesState {
    final int videoId;
 const  LikesSuccess(bool liked,this.videoId) : super(liked);
}

class LikesError extends LikesState {
    final int videoId;
const  LikesError(bool liked,this.videoId) : super(liked);
}
