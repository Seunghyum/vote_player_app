enum VoteTypeEnum {
  all('전체', 'all'),
  approve('찬성', 'approve'),
  oppose('반대', 'oppose'),
  abstain('기권', 'abstain'),
  absent('불참', 'absent');

  const VoteTypeEnum(
    this.koreanName,
    this.englishName,
  );
  final String koreanName;
  final String englishName;
}

VoteTypeEnum getVoteTypeStatus(String status) {
  if (status == VoteTypeEnum.approve.koreanName ||
      status == VoteTypeEnum.approve.englishName) {
    return VoteTypeEnum.approve;
  } else if (status == VoteTypeEnum.oppose.koreanName ||
      status == VoteTypeEnum.oppose.englishName) {
    return VoteTypeEnum.oppose;
  } else if (status == VoteTypeEnum.abstain.koreanName ||
      status == VoteTypeEnum.abstain.englishName) {
    return VoteTypeEnum.abstain;
  } else if (status == VoteTypeEnum.absent.koreanName ||
      status == VoteTypeEnum.absent.englishName) {
    return VoteTypeEnum.absent;
  } else if (status == VoteTypeEnum.all.koreanName ||
      status == VoteTypeEnum.all.englishName) {
    return VoteTypeEnum.all;
  }
  throw 'VoteTypeStatus에 예외가 있습니다 $status';
}
