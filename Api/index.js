const express = require('express');
const cors = require('cors');

const { initializeApp } = require('firebase/app');
const { getFirestore, collection, getDocs, addDoc, getDoc, doc, setDoc} = require('firebase/firestore/lite'); 
const firebaseConfig = require('./config');
const { generateAnswer, translate, explainGrammar, getVocabularyFromSentence } = require('./javascript/model');

const fb_app = initializeApp(firebaseConfig);
const db = getFirestore(fb_app);

const app = express();
app.use(express.json());
app.use(cors());

/**
 * all routes for
 * user collection
*/

// Define the getUser function
async function getUser(db) {
  const userCol = collection(db, "user");
  const userSnapshot = await getDocs(userCol);
  const userList = userSnapshot.docs.map((doc) => doc.data());
  return userList;
}
  
// Define the route for getting users
app.get("/users", async (req, res) => {
  try {
    const userList = await getUser(db);
    res.status(200).send(JSON.stringify(userList));
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// Define the route for getting users
app.post("/newUser", async (req, res) => {
  try {
    const users = collection(db, "user");
    docRef = await addDoc(users, {key: "123"})
    res.status(200).json({userId: docRef.id});
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

// Get chats
app.get("/api/user/:userId/chats", async (req, res) => {
  try {
    const userId = req.params.userId;
    const chatsRef = collection(db, "user", userId, "chats");
    const querySnapshot = await getDocs(chatsRef);
    const chats = querySnapshot.docs.map((doc) => doc.data());
    console.log(chats);
    res.json(chats);
  } catch (error) {
    console.log("Error getting documents: ", error);
    res.status(500).send("Error getting documents");
  }
});

// Get vocab list
app.get("/api/user/:userId/vocabulary", async (req, res) => {
  try {
    const userId = req.params.userId;
    const vocabRef = collection(db, "user", userId, "vocabulary");
    const querySnapshot = await getDocs(vocabRef);
    const chats = querySnapshot.docs.map((doc) => doc.data());
    // Combine into a single list
    const result = {};
    chats.forEach(element => {
      result[element.key] = element.value;
    });
    console.log(result);
    res.json(result);
  } catch (error) {
    console.log("Error getting documents: ", error);
    res.status(500).send("Error getting documents");
  }
});

// Set vocab
app.post("/api/user/:userId/vocabulary", async (req, res) => {
  try {
    const userId = req.params.userId;
    const data = req.body;
    const vocabRef = collection(db, "user", userId, "vocabulary");
    vocabRefNew = await addDoc(vocabRef, {
      "key": data.key,
      "value": data.value
    });
    res.status(200).send("Success");
  } catch (error) {
    console.log("Error getting documents: ", error);
    res.status(500).send("Error getting documents");
  }
});

//add new chat
app.post("/api/user/:userId/newChat", async (req, res) => {
  try {
    const userId = req.params.userId;
    const data = req.body;
    const chatCol = collection(db, "user", userId, "chats");
    chatRef = await addDoc(chatCol, {
      key: data.key,
      niveau: data.niveau
    })
    res.status(200).json({"chatId": chatRef.id});
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "error adding chat" });
  }
});

// Post chat content
app.post("/api/user/:userId/chats/:chatId/sendMessage", async (req, res) => {
    try {
      const data = req.body; // parsed JSON data
      const userId = req.params.userId;
      const chatId = req.params.chatId;

      const chatRef = collection(db, "user", userId, "chats", chatId, "messages");
      const messageRef = await addDoc(chatRef, {
        description: "",
        id: "todo: id is unecessary?",
        messages: data.message,
        time: Date.now(),
        user: "Human"
      })
      
      res.status(200).send("Success");
    } catch (error) {
      console.log("Error getting documents: ", error);
      res.status(500).send("Error getting documents");
    }
  });

// Get chat content
app.get("/api/user/:userId/chats/:chatId/messages", async (req, res) => {
    try {
      const userId = req.params.userId;
      const chatId = req.params.chatId;
      const chatsRef = collection(db, "user", userId, "chats", chatId, "messages");
      const querySnapshot = await getDocs(chatsRef);
      const chatContent = querySnapshot.docs.map((doc) => doc.data());
      console.log(chatContent);
      res.json(chatContent);
    } catch (error) {
      console.log("Error getting documents: ", error);
      res.status(500).send("Error getting documents");
    }
  });

  // Post chat content
app.post("/api/user/:userId/chats/:chatId/generateResponse", async (req, res) => {
    try {
      const userId = req.params.userId;
      const chatId = req.params.chatId;
      const language = req.body.language;

      // Generate chat history
      const humanMessages = [];
      const aiMessages = [];
      const messagesRef = collection(db, "user", userId, "chats", chatId, "messages");
      const querySnapshot = await getDocs(messagesRef);
      querySnapshot.docs.forEach(doc => {
        const data = doc.data();
        if(data.user == "Human"){
          humanMessages.push(data.messages)
        } else {
          aiMessages.push(data.messages)
        }
      });
      if(aiMessages.length >= humanMessages.length) {
        return res.status(500).send("Ai already responded!");
      }

      // Get language level
      const chatsRef = collection(db, "user", userId, "chats");
      const chatRef = doc(chatsRef, chatId);
      const chatDocSnapshot = await getDoc(chatRef);
      const niveau = chatDocSnapshot.data().niveau ?? "A1";

      // Get partner name
      const partnerName = chatDocSnapshot.data().partnerName ?? "Jürgen";

      // Generate response
      const answer = await generateAnswer(language, niveau, partnerName, humanMessages, aiMessages)

      // Save AI message
      const messages = collection(db, "user", userId, "chats", chatId, "messages");
      const messageRef = await addDoc(messages, {
        description: "",
        id: "todo: id is unecessary?",
        messages: answer,
        time: Date.now(),
        user: "Ai"
      })
      
      // Return new chat
      const chatsRefUpdated = collection(db, "user", userId, "chats", chatId, "messages");
      const querySnapshotUpdated = await getDocs(chatsRefUpdated);
      const chatContent = querySnapshotUpdated.docs.map((doc) => doc.data());
      console.log(chatContent);
      res.json(chatContent);
    } catch (error) {
      console.log("Error getting documents: ", error);
      res.status(500).send("Error getting documents");
    }
  });

// Get chat niveau
app.get("/api/user/:userId/chats/:chatId/languageLevel", async (req, res) => {
  try {
    const userId = req.params.userId;
    const chatId = req.params.chatId;
    const chatsRef = collection(db, "user", userId, "chats");
    const chatRef = doc(chatsRef, chatId);
    const chatDocSnapshot = await getDoc(chatRef);

    console.log(chatDocSnapshot.data().niveau);
    res.json(chatDocSnapshot.data().niveau);
  } catch (error) {
    console.log("Error getting documents: ", error);
    res.status(500).send("Error getting documents");
  }
});

app.post("/api/explainGrammar", async (req, res) => {
  try {
    const message = req.body.message;
    const outputLanguage = req.body.outputLanguage;

    const explanation = await explainGrammar(message, outputLanguage)
    res.status(200).json({"explanation": explanation});
  } catch (error) {
    console.log("Error explaining sentence: ", error);
    res.status(500).send("Error getting documents");
  }
});

app.post("/api/translate", async (req, res) => {
  try {
    const message = req.body.message;
    const outputLanguage = req.body.outputLanguage;

    const translation = await translate(message, outputLanguage)
    res.status(200).json({"translation": translation});
  } catch (error) {
    console.log("Error translating sentence: ", error);
    res.status(500).send("Error getting documents");
  }
});

app.post("/api/getVocabularyFromSentence", async (req, res) => {
  try {
    const message = req.body.message;
    const outputLanguage = req.body.outputLanguage;

    const vocab = await getVocabularyFromSentence(message, outputLanguage)
    // Todo: convert data structure necessary?
    res.status(200).json(vocab);
  } catch (error) {
    console.log("Error getting vocabulary: ", error);
    res.status(500).send("Error getting documents");
  }
});


app.listen(4000, ()=>console.log("Up and running *4000"));