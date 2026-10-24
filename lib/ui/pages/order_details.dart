import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_colors.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderDetailsController(),
      child: _OrderDetailsPage(),
    );
  }
}

class _OrderDetailsPage extends StatelessWidget {
  const _OrderDetailsPage();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Novo Pedido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'PED-0004',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cliente',
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6ECF8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.storefront_outlined,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selecionar Cliente',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produtos',
                        style: TextStyle(fontSize: 18, fontWeight: .w700),
                      ),
                      Text(
                        '+ Adicionar produto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w700,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(Icons.storage_outlined),
                          const SizedBox(height: 5),
                          Text(
                            'Nenhum produto cadastrado',
                            style: TextStyle(fontSize: 18, fontWeight: .w900),
                          ),
                          Text(
                            'Adicione os itens que o cliente solicitou',
                            style: TextStyle(fontSize: 16, fontWeight: .w200),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '+ Adicionar Produto',
                              style: TextStyle(fontWeight: .w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Transportadota',
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6ECF8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.local_shipping_outlined,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selecionar Cliente',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Endereço de entrega',
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),
                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          //TODO COLOCAR MAPS E ENDERECO
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
