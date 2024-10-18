class FakeData {
  // events data
  static List<Map<String, String>> events = [
    {
      "title": "Entrainement Tailwind",
      "image":
          "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Entraînement sur Tailwind CSS",
      "date": "2022-03-15T10:00:00Z",
      "participants": "5",
    },
    {
      "title": "Entraide projet Flutter",
      "image":
          "https://images.unsplash.com/photo-1716348300558-c81409ed958a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Entraide sur un projet Flutter",
      "date": "2022-03-15T14:00:00Z",
      "participants": "3",
    },
    {
      "title": "Révisions de Sécurité Web",
      "image":
          "https://images.unsplash.com/photo-1670934265254-954bd96352ba?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
      "description": "Révisions de sécurité web",
      "date": "2022-03-16T09:00:00Z",
      "participants": "2",
    },
    {
      "title": "Entraide FYC",
      "image":
          "https://images.unsplash.com/photo-1653203187698-530a34a80ba5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGNvdXJzfGVufDB8fDB8fHwy",
      "description": "Entraide sur le projet FYC",
      "date": "2022-03-16T14:00:00Z",
      "participants": "4",
    },
  ];

  // user data
  static Map<String, String> user = {
    "name": "John Doe",
    "bio":
        "Développeur Flutter passionné par la création d'applications mobiles et web.",
    "email": "johndoe@example.com",
    "phone": "06 12 34 56 78",
    "location": "Paris, France",
    "image":
        "https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?q=80&w=2830&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  };

  // conversations data
  static List<Map<String, String>> conversations = [
    {
      "name": "Alice Dupont",
      "lastMessage": "Salut, comment ça va ?",
      "date": "2024-10-15T10:30:00Z",
    },
    {
      "name": "Bob Martin",
      "lastMessage": "À demain pour la réunion.",
      "date": "2024-10-14T10:30:00Z",
    },
    {
      "name": "Chloé Durant",
      "lastMessage": "Merci pour ton aide !",
      "date": "2021-09-13T08:45:00Z",
    },
    {
      "name": "David Leroy",
      "lastMessage": "On se voit ce soir ?",
      "date": "2021-09-12T20:00:00Z",
    },
    {
      "name": "Emma Laroche",
      "lastMessage": "J'ai envoyé le fichier.",
      "date": "2021-09-11T14:30:00Z",
    },
  ];

  // event details data
  static Map<String, dynamic> eventDetails = {
    "title": "Entrainement Tailwind",
    "image":
        "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y291cnN8ZW58MHx8MHx8fDI%3D",
    "description": "Entraînement sur Tailwind CSS",
    "date": "2024-10-19T10:00:00Z",
    // "physical_event": {
    //   "address": "Paris, France",
    // },
    "remote_event": {
      "link": "https://meet.google.com/abc-defg-hij",
    },
    "participants": [
      {
        'name': 'Alice',
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D',
      },
      {
        'name': 'Bob',
        'image':
            'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D',
      }
    ],
    "event_documents": [
      {
        'title': 'Cours sur Flutter',
        'description':
            'Introduction au développement d\'applications avec Flutter.',
      },
      {
        'title': 'Exercice de JavaScript',
        'description': 'Pratique des concepts de base en JavaScript.',
      },
    ],
    "last_messages": [
      {
        'sender': {
          'name': 'Alice',
          'image':
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D',
        },
        'message': 'Hâte de voir tout le monde à cet événement !',
      },
      {
        'sender': {
          'name': 'Bob',
          'image':
              'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D',
        },
        'message': 'Ça va être génial !',
      },
      {
        'sender': {
          'name': 'Alice',
          'image':
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8Mg%3D%3D',
        },
        'message': 'Je viendrai avec des amis.',
      },
    ]
  };
}
