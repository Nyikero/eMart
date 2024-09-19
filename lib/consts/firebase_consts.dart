import 'package:e_mart/consts/consts.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

// Collections
const usersCollection = "users";
const productsCollection = "products";
const cartCollection = 'cart';
const chatsCollection = 'chats';
const messagesCollection = 'messages';

const ordersCollection = 'orders';
