# ScannerApp

Visão Geral:
Este é um aplicativo móvel desenvolvido em Flutter que permite aos usuários digitalizar textos e imagens usando a câmera do dispositivo. O aplicativo utiliza uma série de pacotes e integrações para facilitar a digitalização de documentos e oferecer opções para compartilhar ou imprimir o conteúdo escaneado. A integração com o Firebase possibilita o armazenamento e compartilhamento dos documentos digitalizados na nuvem.

Recursos Principais:

Digitalização de Texto: O aplicativo utiliza o pacote "google_mlkit_text_recognition" para digitalizar textos a partir de imagens capturadas pela câmera do dispositivo. A tecnologia de reconhecimento de texto do Google ML Kit é utilizada para extrair as letras e palavras dos documentos fotografados.

Digitalização de Imagem: Além da digitalização de texto, o aplicativo também permite aos usuários digitalizar imagens usando a câmera do dispositivo. O pacote "image_picker" é utilizado para acessar a galeria de fotos ou tirar novas fotos.

Cropping de Imagem: O pacote "image_cropper" é utilizado para permitir que os usuários cortem as imagens escaneadas e selecionem apenas a parte relevante do documento antes de salvá-lo.

Armazenamento em Nuvem: A integração com o Firebase (pacote "firebase_core") possibilita o armazenamento seguro dos documentos digitalizados na nuvem. Isso permite que os usuários acessem e compartilhem seus documentos em qualquer dispositivo.

Compartilhamento e Impressão: Os pacotes "flutter_share" e "share_plus" são usados para fornecer opções para compartilhar o conteúdo digitalizado através de aplicativos de mensagens, e-mail ou mídias sociais. Além disso, o pacote "open_file" permite a visualização dos documentos digitalizados antes de compartilhá-los ou imprimir através de aplicativos compatíveis.

Instruções para Execução:
Para executar o aplicativo, certifique-se de ter todos os pacotes listados no arquivo "pubspec.yaml" instalados em sua máquina local. Use o comando flutter pub get para baixar todas as dependências necessárias. Em seguida, conecte um dispositivo móvel ao seu computador ou inicie um emulador e execute o aplicativo usando o comando flutter run.

Observações Finais:
O aplicativo de digitalização de texto e imagem para impressão é uma ferramenta útil para capturar documentos importantes, notas escritas à mão ou qualquer outra informação que precisa ser arquivada, compartilhada ou impressa. A integração do Firebase garante a segurança dos documentos escaneados, enquanto a interface amigável permite uma experiência de usuário simples e eficiente.

Lembre de alterar a chave do firebase.

![Screenshot_20230730-220001](https://github.com/JhonSilva98/ScannerApp/assets/53879683/57264eda-3763-488a-9394-46812f8a09e6)
![Screenshot_20230730-220008_Permission controller](https://github.com/JhonSilva98/ScannerApp/assets/53879683/4884fdbc-ddfa-4bca-9561-23a7e8beab5d)
![Screenshot_20230730-220015](https://github.com/JhonSilva98/ScannerApp/assets/53879683/02a2dc8f-7c1a-4598-a855-fdb6abb337e6)
![Screenshot_20230730-220026](https://github.com/JhonSilva98/ScannerApp/assets/53879683/d92ea01e-e1de-4f01-ac3c-1e686f8d39d2)
![Screenshot_20230730-220104](https://github.com/JhonSilva98/ScannerApp/assets/53879683/bc7d1170-069d-4bd0-bb27-7109a414e623)
![Screenshot_20230730-220115](https://github.com/JhonSilva98/ScannerApp/assets/53879683/2ddfda42-7316-4885-bf71-d5c0f8c150d6)
![Screenshot_20230730-220550](https://github.com/JhonSilva98/ScannerApp/assets/53879683/9d271d67-7e69-4ac2-be18-032f977110bd)
![Screenshot_20230730-221908](https://github.com/JhonSilva98/ScannerApp/assets/53879683/838b4a07-ca7a-4434-8f62-7b1c63e9b749)
![Screenshot_20230730-220601_Drive](https://github.com/JhonSilva98/ScannerApp/assets/53879683/6f67b33b-05f9-4ae9-a083-56ad1878a1cd)




