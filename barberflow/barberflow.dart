-- =========================================
-- BARBERFLOW - Schema inicial
-- =========================================

-- 1. CLIENTES
create table public.clientes (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  cpf varchar(14) unique not null,
  whatsapp text,
  created_at timestamp default now(),
  consentimento_lgpd_em timestamp,
  consentimento_versao text default 'v1.0'
);

-- 2. BARBEARIAS
create table public.barbearias (
  id uuid primary key default gen_random_uuid(),
  nome text,
  dono_email text,
  abre_as time,
  fecha_as time
);

-- 3. AGENDAMENTOS
create table public.agendamentos (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references public.clientes(id),
  barbearia_id uuid references public.barbearias(id),
  data_hora_solicitada timestamp,
  status text check (status in ('pendente', 'aceito', 'recusado')),
  motivo_recusa text,
  criado_em timestamp default now()
);

-- Índices nas chaves estrangeiras
create index idx_agendamentos_cliente_id on public.agendamentos(cliente_id);
create index idx_agendamentos_barbearia_id on public.agendamentos(barbearia_id);

-- =========================================
-- REALTIME na tabela agendamentos
-- =========================================
alter publication supabase_realtime add table public.agendamentos;


flutter pub add supabase_flutter shared_preferences intl
flutter pub add flutter_localizations --sdk=flutter

lib/
├── main.dart
├── core/
│   ├── config.dart
│   ├── theme.dart
│   ├── cpf.dart
│   └── session.dart
├── models/
│   └── agendamento.dart
├── services/
│   └── repo.dart
├── widgets/
│   ├── gold_button.dart
│   └── termos_modal.dart
└── screens/
    ├── cadastro_screen.dart
    ├── home_screen.dart
    └── meus_agendamentos_screen.dart

    import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config.dart';
import 'core/session.dart';
import 'core/theme.dart';
import 'screens/cadastro_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );
  await Session.init();
  runApp(const BarberFlowApp());
}

class BarberFlowApp extends StatelessWidget {
  const BarberFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarberFlow',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Session.clienteId == null
          ? const CadastroScreen()
          : const HomeScreen(),
    );
  }
}

class AppConfig {
  // Supabase > Project Settings > API
  static const supabaseUrl = 'https://SEU-PROJETO.supabase.co';
  static const supabaseAnonKey = 'SUA_ANON_KEY';
}


import 'package:flutter/material.dart';

class AppColors {
  static const preto = Color(0xFF0A0A0A);
  static const grafite = Color(0xFF161616);
  static const grafite2 = Color(0xFF1F1F1F);
  static const borda = Color(0xFF2E2A1E);

  static const dourado = Color(0xFFD4AF37);
  static const douradoClaro = Color(0xFFF1D77A);
  static const douradoEscuro = Color(0xFF9C7A1E);
  static const douradoSombra = Color(0x40D4AF37);

  static const texto = Color(0xFFF5F0E1);
  static const textoSuave = Color(0xFF9A9486);

  static const pendente = Color(0xFFFFD60A); // amarelo
  static const aceito = Color(0xFF2ECC71); // verde
  static const recusado = Color(0xFFE5484D); // vermelho
}

ThemeData buildTheme() {
  final base = ThemeData.dark(useMaterial3: true);

  OutlineInputBorder borda(Color c, [double w = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c, width: w),
      );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.preto,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.dourado,
      onPrimary: AppColors.preto,
      secondary: AppColors.douradoClaro,
      surface: AppColors.grafite,
      onSurface: AppColors.texto,
      error: AppColors.recusado,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.texto,
      displayColor: AppColors.texto,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.preto,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColors.dourado,
      titleTextStyle: TextStyle(
        color: AppColors.dourado,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 4,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grafite,
      labelStyle: const TextStyle(color: AppColors.textoSuave),
      floatingLabelStyle: const TextStyle(color: AppColors.dourado),
      prefixIconColor: AppColors.douradoEscuro,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: borda(AppColors.borda),
      focusedBorder: borda(AppColors.dourado, 1.6),
      errorBorder: borda(AppColors.recusado),
      focusedErrorBorder: borda(AppColors.recusado, 1.6),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? AppColors.dourado : null,
      ),
      checkColor: const WidgetStatePropertyAll(AppColors.preto),
      side: const BorderSide(color: AppColors.dourado, width: 1.6),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.grafite,
      headerBackgroundColor: AppColors.grafite2,
      headerForegroundColor: AppColors.dourado,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: AppColors.grafite,
      hourMinuteColor: AppColors.grafite2,
      dialBackgroundColor: AppColors.grafite2,
      dialHandColor: AppColors.dourado,
      entryModeIconColor: AppColors.dourado,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.grafite2,
      contentTextStyle: const TextStyle(color: AppColors.texto),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.douradoEscuro),
      ),
    ),
  );
}

import 'package:flutter/services.dart';

class CpfUtils {
  static String onlyDigits(String s) => s.replaceAll(RegExp(r'\D'), '');

  /// Valida tamanho, sequências repetidas e os 2 dígitos verificadores.
  static bool isValid(String cpf) {
    final d = onlyDigits(cpf);
    if (d.length != 11) return false;
    if (RegExp(r'^(\d)\1{10}$').hasMatch(d)) return false;

    int digito(int len) {
      var soma = 0;
      for (var i = 0; i < len; i++) {
        soma += int.parse(d[i]) * (len + 1 - i);
      }
      final r = (soma * 10) % 11;
      return r == 10 ? 0 : r;
    }

    return digito(9) == int.parse(d[9]) && digito(10) == int.parse(d[10]);
  }
}

/// Máscara 000.000.000-00
class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var d = CpfUtils.onlyDigits(newValue.text);
    if (d.length > 11) d = d.substring(0, 11);

    final b = StringBuffer();
    for (var i = 0; i < d.length; i++) {
      if (i == 3 || i == 6) b.write('.');
      if (i == 9) b.write('-');
      b.write(d[i]);
    }
    final texto = b.toString();
    return TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';

/// Guarda localmente quem é o cliente logado neste aparelho.
class Session {
  static late SharedPreferences _p;
  static const _kId = 'cliente_id';
  static const _kNome = 'cliente_nome';

  static Future<void> init() async {
    _p = await SharedPreferences.getInstance();
  }

  static String? get clienteId => _p.getString(_kId);
  static String? get nome => _p.getString(_kNome);

  static Future<void> salvar(String id, String nome) async {
    await _p.setString(_kId, id);
    await _p.setString(_kNome, nome);
  }

  static Future<void> sair() async {
    await _p.remove(_kId);
    await _p.remove(_kNome);
  }
}

import 'package:flutter/material.dart';
import '../core/theme.dart';

enum StatusAgendamento { pendente, aceito, recusado }

extension StatusX on StatusAgendamento {
  String get label => switch (this) {
        StatusAgendamento.pendente => 'Pendente',
        StatusAgendamento.aceito => 'Aceito',
        StatusAgendamento.recusado => 'Recusado',
      };

  Color get cor => switch (this) {
        StatusAgendamento.pendente => AppColors.pendente,
        StatusAgendamento.aceito => AppColors.aceito,
        StatusAgendamento.recusado => AppColors.recusado,
      };

  IconData get icone => switch (this) {
        StatusAgendamento.pendente => Icons.hourglass_top_rounded,
        StatusAgendamento.aceito => Icons.check_circle_rounded,
        StatusAgendamento.recusado => Icons.cancel_rounded,
      };
}

class Agendamento {
  final String id;
  final DateTime? dataHora;
  final StatusAgendamento status;
  final String? motivoRecusa;

  Agendamento({
    required this.id,
    required this.dataHora,
    required this.status,
    this.motivoRecusa,
  });

  factory Agendamento.fromMap(Map<String, dynamic> m) {
    final raw = m['data_hora_solicitada'] as String?;
    return Agendamento(
      id: m['id'] as String,
      // timestamp sem timezone -> interpretado como horário local
      dataHora: raw == null ? null : DateTime.parse(raw),
      status: StatusAgendamento.values.firstWhere(
        (s) => s.name == m['status'],
        orElse: () => StatusAgendamento.pendente,
      ),
      motivoRecusa: m['motivo_recusa'] as String?,
    );
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/agendamento.dart';
import '../widgets/termos_modal.dart';

class Repo {
  static final _db = Supabase.instance.client;

  /// Cadastra o cliente. Se o CPF já existir (unique), reaproveita o cadastro.
  static Future<Map<String, dynamic>> cadastrarOuEntrar({
    required String nome,
    required String cpfFormatado,
  }) async {
    try {
      return await _db
          .from('clientes')
          .insert({
            'nome': nome,
            'cpf': cpfFormatado,
            'consentimento_lgpd_em': DateTime.now().toUtc().toIso8601String(),
            'consentimento_versao': Termos.versao,
          })
          .select()
          .single();
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return await _db
            .from('clientes')
            .select()
            .eq('cpf', cpfFormatado)
            .single();
      }
      rethrow;
    }
  }

  static Future<String> _barbeariaId() async {
    final row = await _db.from('barbearias').select('id').limit(1).maybeSingle();
    if (row == null) {
      throw Exception('Nenhuma barbearia cadastrada.');
    }
    return row['id'] as String;
  }

  static Future<void> solicitarCorte({
    required String clienteId,
    required DateTime dataHora,
  }) async {
    final barbeariaId = await _barbeariaId();
    await _db.from('agendamentos').insert({
      'cliente_id': clienteId,
      'barbearia_id': barbeariaId,
      // DateTime local -> ISO sem "Z", combina com timestamp sem timezone
      'data_hora_solicitada': dataHora.toIso8601String(),
      'status': 'pendente',
    });
  }

  /// Stream em tempo real (Supabase Realtime) dos agendamentos do cliente.
  static Stream<List<Agendamento>> streamAgendamentos(String clienteId) {
    return _db
        .from('agendamentos')
        .stream(primaryKey: ['id'])
        .eq('cliente_id', clienteId)
        .order('data_hora_solicitada', ascending: false)
        .map((rows) => rows.map(Agendamento.fromMap).toList());
  }
}

import 'package:flutter/material.dart';
import '../core/theme.dart';

class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;

  const GoldButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ativo = onPressed != null && !loading;
    final radius = BorderRadius.circular(14);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: (ativo || loading) ? 1 : 0.4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.douradoClaro,
              AppColors.dourado,
              AppColors.douradoEscuro,
            ],
          ),
          boxShadow: ativo
              ? const [
                  BoxShadow(
                    color: AppColors.douradoSombra,
                    blurRadius: 18,
                    offset: Offset(0, 6),
                  ),
                ]
              : const [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: ativo ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Center(
                child: loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.4,
                          color: AppColors.preto,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            Icon(icon, color: AppColors.preto, size: 20),
                            const SizedBox(width: 10),
                          ],
                          Text(
                            label.toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.preto,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'gold_button.dart';

class Termos {
  static const versao = 'v1.0';

  static const texto = '''
TERMOS DE USO E TRATAMENTO DE DADOS PESSOAIS (v1.0)

1. Quais dados coletamos
Coletamos apenas o seu nome completo e o seu CPF.

2. Para que usamos
Usamos esses dados exclusivamente para identificar você e controlar os seus agendamentos na barbearia. Não usamos seus dados para outras finalidades.

3. Compartilhamento
Seus dados não são vendidos nem compartilhados com terceiros para fins de marketing. Apenas a barbearia em que você agenda tem acesso a eles, para confirmar e gerenciar os horários.

4. Armazenamento e segurança
Os dados ficam armazenados em ambiente seguro e são mantidos enquanto o seu cadastro estiver ativo ou pelo tempo exigido por lei.

5. Seus direitos (Lei nº 13.709/2018 - LGPD)
Você pode, a qualquer momento: confirmar a existência de tratamento, acessar seus dados, corrigir dados incorretos, solicitar a eliminação dos dados, e revogar este consentimento. Para isso, fale com a barbearia.

6. Consentimento
Ao marcar a caixa de aceite no cadastro, você declara que leu e concorda com estes Termos e autoriza o uso do seu CPF e nome exclusivamente para identificação e controle de agendamentos. Registramos a data e a versão do aceite.
''';
}

Future<void> mostrarTermos(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.grafite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      side: BorderSide(color: AppColors.douradoEscuro),
    ),
    builder: (ctx) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scroll) => Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.douradoEscuro,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'TERMOS E PRIVACIDADE',
            style: TextStyle(
              color: AppColors.dourado,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.borda, height: 1),
          Expanded(
            child: SingleChildScrollView(
              controller: scroll,
              padding: const EdgeInsets.all(24),
              child: const Text(
                Termos.texto,
                style: TextStyle(
                  color: AppColors.texto,
                  height: 1.55,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: GoldButton(
              label: 'Entendi',
              onPressed: () => Navigator.pop(ctx),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import '../core/cpf.dart';
import '../core/session.dart';
import '../core/theme.dart';
import '../services/repo.dart';
import '../widgets/gold_button.dart';
import '../widgets/termos_modal.dart';
import 'home_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _cpf = TextEditingController();
  bool _aceito = false;
  bool _loading = false;

  @override
  void dispose() {
    _nome.dispose();
    _cpf.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_aceito || !_form.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final cliente = await Repo.cadastrarOuEntrar(
        nome: _nome.text.trim(),
        cpfFormatado: _cpf.text,
      );
      await Session.salvar(cliente['id'] as String, cliente['nome'] as String);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível concluir o cadastro. Tente novamente.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.dourado, width: 1.6),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.douradoSombra,
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.content_cut_rounded,
                          color: AppColors.dourado,
                          size: 38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'BARBERFLOW',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.dourado,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Crie seu cadastro para agendar',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textoSuave),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      controller: _nome,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nome completo',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      validator: (v) {
                        final partes = (v ?? '')
                            .trim()
                            .split(RegExp(r'\s+'))
                            .where((p) => p.isNotEmpty);
                        return partes.length < 2
                            ? 'Informe nome e sobrenome'
                            : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _cpf,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CpfInputFormatter()],
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                        hintText: '000.000.000-00',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      validator: (v) =>
                          CpfUtils.isValid(v ?? '') ? null : 'CPF inválido',
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      value: _aceito,
                      onChanged: (v) => setState(() => _aceito = v ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.dourado,
                      title: const Text(
                        'Li e concordo com os Termos e autorizo o uso do meu CPF e nome exclusivamente para identificação e controle de agendamentos, conforme a LGPD.',
                        style: TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => mostrarTermos(context),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.dourado,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                        ),
                        child: const Text(
                          'Ver Termos',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.dourado,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GoldButton(
                      label: 'Cadastrar',
                      loading: _loading,
                      onPressed: _aceito ? _enviar : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../core/session.dart';
import '../core/theme.dart';
import '../services/repo.dart';
import '../widgets/gold_button.dart';
import 'cadastro_screen.dart';
import 'meus_agendamentos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;

  void _aviso(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _solicitarCorte() async {
    final agora = DateTime.now();

    final data = await showDatePicker(
      context: context,
      initialDate: agora,
      firstDate: DateTime(agora.year, agora.month, agora.day),
      lastDate: agora.add(const Duration(days: 90)),
      helpText: 'ESCOLHA O DIA',
      cancelText: 'Cancelar',
      confirmText: 'Continuar',
    );
    if (data == null || !mounted) return;

    final hora = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      helpText: 'ESCOLHA O HORÁRIO',
      cancelText: 'Cancelar',
      confirmText: 'Solicitar',
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (hora == null || !mounted) return;

    final dataHora =
        DateTime(data.year, data.month, data.day, hora.hour, hora.minute);

    if (dataHora.isBefore(DateTime.now())) {
      _aviso('Escolha um horário no futuro.');
      return;
    }

    setState(() => _loading = true);
    try {
      await Repo.solicitarCorte(
        clienteId: Session.clienteId!,
        dataHora: dataHora,
      );
      if (!mounted) return;
      _aviso('Solicitação enviada! Aguarde a confirmação da barbearia.');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MeusAgendamentosScreen()),
      );
    } catch (_) {
      if (!mounted) return;
      _aviso('Não foi possível enviar a solicitação. Tente novamente.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _sair() async {
    await Session.sair();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CadastroScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primeiroNome = (Session.nome ?? '').split(' ').first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BARBERFLOW'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout_rounded),
            onPressed: _sair,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Olá, $primeiroNome',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Pronto para um visual impecável?',
                    style: TextStyle(color: AppColors.textoSuave),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.grafite,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.douradoEscuro),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.douradoSombra,
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.content_cut_rounded,
                          color: AppColors.dourado,
                          size: 46,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Agende seu corte',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Escolha o dia e o horário. A barbearia vai confirmar o seu pedido.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textoSuave,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 26),
                        GoldButton(
                          label: 'Solicitar Corte',
                          icon: Icons.event_available_rounded,
                          loading: _loading,
                          onPressed: _solicitarCorte,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MeusAgendamentosScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.list_alt_rounded),
                    label: const Text('MEUS AGENDAMENTOS'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.dourado,
                      side: const BorderSide(color: AppColors.douradoEscuro),
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/session.dart';
import '../core/theme.dart';
import '../models/agendamento.dart';
import '../services/repo.dart';

class MeusAgendamentosScreen extends StatelessWidget {
  const MeusAgendamentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteId = Session.clienteId!;

    return Scaffold(
      appBar: AppBar(title: const Text('MEUS AGENDAMENTOS')),
      body: StreamBuilder<List<Agendamento>>(
        stream: Repo.streamAgendamentos(clienteId),
        builder: (context, snap) {
          if (snap.hasError) {
            return const _Mensagem(
              icone: Icons.wifi_off_rounded,
              texto: 'Não foi possível carregar seus agendamentos.',
            );
          }
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.dourado),
            );
          }
          final lista = snap.data!;
          if (lista.isEmpty) {
            return const _Mensagem(
              icone: Icons.event_busy_rounded,
              texto: 'Você ainda não tem agendamentos.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: lista.length,
            itemBuilder: (_, i) => _AgendamentoCard(a: lista[i]),
          );
        },
      ),
    );
  }
}

class _AgendamentoCard extends StatelessWidget {
  final Agendamento a;
  const _AgendamentoCard({required this.a});

  static String _cap(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final cor = a.status.cor;
    final dt = a.dataHora;
    final dia = dt == null
        ? '--'
        : _cap(DateFormat("EEEE, dd 'de' MMMM", 'pt_BR').format(dt));
    final hora = dt == null ? '--:--' : DateFormat('HH:mm').format(dt);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.grafite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cor.withAlpha(90)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: cor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              dia,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _StatusChip(status: a.status),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_rounded,
                            size: 16,
                            color: AppColors.dourado,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            hora,
                            style: const TextStyle(
                              color: AppColors.dourado,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      if (a.status == StatusAgendamento.recusado) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.recusado.withAlpha(30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Motivo: ${(a.motivoRecusa?.trim().isNotEmpty ?? false) ? a.motivoRecusa : 'não informado'}',
                            style: const TextStyle(
                              color: AppColors.recusado,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final StatusAgendamento status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final cor = status.cor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cor.withAlpha(38),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icone, size: 14, color: cor),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: TextStyle(
              color: cor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Mensagem extends StatelessWidget {
  final IconData icone;
  final String texto;
  const _Mensagem({required this.icone, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 52, color: AppColors.douradoEscuro),
            const SizedBox(height: 14),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textoSuave),
            ),
          ],
        ),
      ),
    );
  }
}
   insert into barbearias (nome, dono_email, abre_as, fecha_as)
   values ('Barbearia Dom estilos', 'dono@email.com', '09:00', '19:00');