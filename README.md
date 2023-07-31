Descrição do ScannerApp

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

![Screenshot_20230730-220601_Drive](https://github.com/JhonSilva98/ScannerApp/assets/53879683/237b8a6d-1c15-4210-ad6d-360f4916f42a)
![Screenshot_20230730-220550](https://github.com/JhonSilva98/ScannerApp/assets/53879683/9a6d4feb-148d-4a68-83af-db8e0ae7cfa0)
![Screenshot_20230730-220115](https://github.com/JhonSilva98/ScannerApp/assets/53879683/3f41812e-6d33-4b7f-9b84-7071a28e7581)
![Screenshot_20230730-220104](https://github.com/JhonSilva98/ScannerApp/assets/53879683/b1bb653e-7c19-4be9-8e26-ddd201727c70)
![Screenshot_20230730-220026](https://github.com/JhonSilva98/ScannerApp/assets/53879683/c4f25559-acdd-4fc1-b008-ae1f1dd89dab)
![Screenshot_20230730-220015](https://github.com/JhonSilva98/ScannerApp/assets/53879683/ef23d3f5-f6df-4641-9173-00f971ec71c8)
![Screenshot_20230730-220008_Permission controller](https://github.com/JhonSilva98/ScannerApp/assets/53879683/b91cdd7a-4044-40f9-92e1-4dcc5bdbddb7)
![Screenshot_20230730-220001](https://github.com/JhonSilva98/ScannerApp/assets/53879683/01889a2a-c98a-4a2d-890e-41ffbe633f6b)



