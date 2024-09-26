class CustomDialogData {
  final String image;
  final String title;
  final String btnText;
  final Function() onBtnPressed;
  final bool isLoading;

  CustomDialogData({
    required this.image,
    required this.btnText,
    required this.title,
    required this.onBtnPressed,
    this.isLoading = false,
  });
}
