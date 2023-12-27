import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomRectangle extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Function onTap;
  final Function(String) onDelete;

  CustomRectangle({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String report = ''; // Variável para armazenar o relatório inserido pelo usuário

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .5),
              blurRadius: 30,
              offset: Offset(10, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 13.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.yellow),
                          Text(
                            '  $description',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Enviar Relatório'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            TextField(
                              onChanged: (text) {
                                report = text; // Atualiza o relatório conforme o usuário digita
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete(report); // Chama onDelete com o relatório como argumento
                              Navigator.of(context).pop();
                            },
                            child: Text('Confirmar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class pageIn extends StatefulWidget {
  pageIn({Key? key}) : super(key: key);

  @override
  _pageInState createState() => _pageInState();
}

class _pageInState extends State<pageIn> {
  List<CustomRectangle> rectangles = [];

  _pageInState() {
    rectangles.add(
      CustomRectangle(
        imagePath: 'assets/images/adress/dezenove.png',
        title: 'R. Dezenove, 290',
        description: 'Piscina',
        onTap: () {
          _showImageDialog('assets/images/results/dezenoveR.jpg');
        },
        onDelete: (report) {
          _deleteRectangle(0, report);
        },
      ),
    );

    rectangles.add(
      CustomRectangle(
        imagePath: 'assets/images/adress/familia_andrade.png',
        title: 'Família Andrade',
        description: 'Piscina',
        onTap: () {
          _showImageDialog('assets/images/results/familia_andradeR.jpg');
        },
        onDelete: (report) {
          _deleteRectangle(1, report);
        },
      ),
    );

    rectangles.add(
      CustomRectangle(
        imagePath: 'assets/images/adress/loreto_garcia.png',
        title: 'R. Lorêto Garcia, 180-220',
        description: 'Pneu',
        onTap: () {
          _showImageDialog('assets/images/results/loreto_garciaR.jpg');
        },
        onDelete: (report) {
          _deleteRectangle(2, report);
        },
      ),
    );

    rectangles.add(
      CustomRectangle(
        imagePath: 'assets/images/adress/quintino_bocaiuva.png',
        title: 'R. Quintino Bocaíuva, 113',
        description: 'Pneu',
        onTap: () {
          _showImageDialog('assets/images/results/quintino_bocaiuvaR.jpg');
        },
        onDelete: (report) {
          _deleteRectangle(3, report);
        },
      ),
    );

    rectangles.add(
      CustomRectangle(
        imagePath: 'assets/images/adress/avenida_sinhamoreira.png',
        title: 'Avenida Sinha Moreira, 350',
        description: 'Piscina / Pneu',
        onTap: () {
          _showVideoDialog('assets/video/avenida_sinhamoreira.mp4');
        },
        onDelete: (report) {
          _deleteRectangle(4, report);
        },
      ),
    );
  }

  void _showImageDialog(String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(imagePath),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showVideoDialog(String videoPath) {
    VideoPlayerController controller = VideoPlayerController.asset(videoPath);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8 / (16 / 9),
            child: VideoPlayer(controller),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.pause();
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );

    controller.initialize().then((_) {
      controller.play();
    });
  }

  void _deleteRectangle(int index, String report) {
    setState(() {
      rectangles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10, top: 65),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.5),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('assets/images/pfp_darf.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      const Text(
                        'DARF / AD',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(20)),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' Focos  Reportados',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),

                  for (var i = 0; i < rectangles.length; i++)
                    Column(
                      children: [
                        rectangles[i],
                        const SizedBox(height: 30),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
