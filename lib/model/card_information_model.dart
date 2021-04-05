class CardInformation {
  final String title;
  final String image;
  final String value;
  final dynamic nextView;
  final Function onClickAction;

  CardInformation({
    this.title,
    this.image,
    this.value,
    this.nextView,
    this.onClickAction,
  });
}
