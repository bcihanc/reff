const kuserID = "20fa1142-24a4-46e5-a21b-e60d6969aeb9";
const kuserID2 = "3c5e8a7f-295a-4bbd-b037-66640f201fb7";

final questionCollectionMock = [
  {
    "id": "d1d0df7a-da3e-46b7-bd45-5aeb3c3c89b7",
    "header": "Bugün seçim olsa hangi partiye oy verirsiniz?",
    "imageUrl": "https://via.placeholder.com/350x150",
    "timeStamp": "2020-07-18T19:31:50.581",
    "answers": [
      "7e54114b-947e-4ddf-ba8d-3d80362a0d32",
      "cc9bcc99-f941-43ce-b82f-334155e72feb",
      "34188b17-7a80-4dab-993d-eba26b4f9f77",
      "48d795fc-9689-499b-8b80-bc2f19690c29"
    ]
  },
  {
    "id": "f6a7e5d3-e2b4-4208-8b8b-ba3d46de377f",
    "header": "En sevdiğiniz renk nedir?",
    "imageUrl": "https://via.placeholder.com/350x150",
    "timeStamp": "2020-08-18T19:31:50.581",
    "answers": [
      "b50bc668-5b15-4931-9d61-3e33e038bb58",
      "9cc3fa1d-e7c7-45a7-9ec2-7938ba4bafa5",
    ]
  },
];

const answerCollectionMock = [
  {"id": "7e54114b-947e-4ddf-ba8d-3d80362a0d32", "content": "akp"},
  {"id": "cc9bcc99-f941-43ce-b82f-334155e72feb", "content": "chp"},
  {"id": "34188b17-7a80-4dab-993d-eba26b4f9f77", "content": "iyip"},
  {"id": "48d795fc-9689-499b-8b80-bc2f19690c29", "content": "hdp"},
  {"id": "b50bc668-5b15-4931-9d61-3e33e038bb58", "content": "siyah"},
  {"id": "9cc3fa1d-e7c7-45a7-9ec2-7938ba4bafa5", "content": "beyaz"},
];

const userCollectionMock = [
  {"id": kuserID, "age": 29, "gender": "MALE", "location": "antalya"},
  {"id": kuserID2, "age": 32, "gender": "FAMALE", "location": "izmir"},
];

const voteCollectionMock = [
//  {
//    "id": "b4386a9a-9128-4c53-9c13-a10b78901634",
//    "userID": "59b22c6f-b580-4375-aca6-bd04bcd38c76",
//    "questionID": "d1d0df7a-da3e-46b7-bd45-5aeb3c3c89b7",
//    "answerID": "34188b17-7a80-4dab-993d-eba26b4f9f77"
//  },
  {
    "id": "b4386a9a-9128-4c53-9c13-a10b78901634",
    "userID": "59b22c6f-b580-4375-aca6-bd04bcd38c76",
    "questionID": "f6a7e5d3-e2b4-4208-8b8b-ba3d46de377f",
    "answerID": "9cc3fa1d-e7c7-45a7-9ec2-7938ba4bafa5"
  },
];
