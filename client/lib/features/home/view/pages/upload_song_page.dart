import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:client/index.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  void selectAudio() async {
    final audio = await pickAudio();
    if (audio != null) {
      setState(() {
        selectedAudio = audio;
      });
    }
  }

  void selectImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        homeViewModelProvider.select((value) => value?.isLoading == true));

    return ResponsiveSizer(
      builder: (p0, p1, p2) => Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Upload Song',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate() &&
                    selectedAudio != null &&
                    selectedImage != null) {
                  ref.read(homeViewModelProvider.notifier).uploadSong(
                        selectedAudio: selectedAudio!,
                        selectedThumbnail: selectedImage!,
                        artist: artistNameController.text,
                        songName: songNameController.text,
                        selectedColor: selectedColor,
                      );
                } else {
                  showSnackBar(
                    context: context,
                    message: 'Please fill all the fields',
                  );
                }
              },
              icon: const Icon(
                Icons.check,
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Loader()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectImage,
                          child: (selectedImage != null)
                              ? SizedBox(
                                  height: 20.h,
                                  width: 100.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : DottedBorder(
                                  color: Pallete.borderColor,
                                  radius: const Radius.circular(20),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  dashPattern: const [10, 5],
                                  child: SizedBox(
                                    height: 20.h,
                                    width: 100.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open,
                                          size: 25.sp,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Select thumbnail for song',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        (selectedAudio != null)
                            ? AudioWave(path: selectedAudio!.path)
                            : CustomField(
                                hintText: 'Pick Song',
                                controller: null,
                                readOnly: true,
                                onTap: selectAudio,
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          hintText: 'Song Name',
                          controller: songNameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomField(
                          hintText: 'Artist Name',
                          controller: artistNameController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ColorPicker(
                          color: selectedColor,
                          pickersEnabled: const <ColorPickerType, bool>{
                            ColorPickerType.wheel: true,
                          },
                          onColorChanged: (Color color) => {
                            selectedColor = color,
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
