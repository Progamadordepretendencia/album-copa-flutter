

// abstract class HomeViewImpl extends State<HomePage>
//     with Loader<HomePage>, Messages<HomePage>
//     implements HomeView {
  
//   UserModel? user;

//   @override
//   void initState() {
//     widget.presenter.view = this;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       widget.presenter.getUserData();
//     });
//     super.initState();
//   }

//   @override
//   void error(String message) {
//     hideLoader();
//     showError(message);
//   }

//   @override
//   void logoutSuccess() {
//     hideLoader();
//     Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
//   }

//   @override
//   void updateUser(UserModel user) {
//     hideLoader();
//     setState(() {
//       this.user = user;
//     });
//   }
// }
