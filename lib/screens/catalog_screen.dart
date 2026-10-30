import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_list_item.dart';
import '../widgets/product_grid_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Product> products = List.from(initialProducts);

  bool isGridView = false;
  int nextId = 7;

  // Pull to Refresh
  Future<void> _refreshProducts() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    if (!mounted) return;

    setState(() {
      products.insert(
        0,
        Product(
          id: nextId++,
          title: 'New Product',
          category: 'New Arrival',
          price: 5000,
          rating: 4.8,
          image: 'assets/images/cream.jpg',
        ),
      );
    });
  }

  // Delete Product and Undo
  void _deleteProduct(Product product, int index) {
    setState(() {
      products.removeWhere(
        (item) => item.id == product.id,
      );
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${product.title} deleted'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              setState(() {
                final restoreIndex =
                    index.clamp(0, products.length).toInt();

                products.insert(restoreIndex, product);
              });
            },
          ),
        ),
      );
  }

  // Reset Catalog
  void _resetCatalog() {
    setState(() {
      products = List.from(initialProducts);
    });
  }

  // Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Catalog is Empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _resetCatalog,
            child: const Text('Reset Catalog'),
          ),
        ],
      ),
    );
  }

  // List View
  Widget _buildListView() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 850,
        ),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: products.length,

          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              thickness: 0.5,
            );
          },

          itemBuilder: (context, index) {
            final product = products[index];

            return Dismissible(
              key: ValueKey(product.id),
              direction: DismissDirection.endToStart,

              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),

              onDismissed: (direction) {
                _deleteProduct(product, index);
              },

              child: ProductListItem(
                product: product,
              ),
            );
          },
        ),
      ),
    );
  }

  // Grid View
  Widget _buildGridView() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 750,
        ),
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: products.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),

          itemBuilder: (context, index) {
            final product = products[index];

            return Dismissible(
              key: ValueKey(product.id),
              direction: DismissDirection.endToStart,

              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),

              onDismissed: (direction) {
                _deleteProduct(product, index);
              },

              child: ProductGridCard(
                product: product,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8F8),
        elevation: 0,

        title: const Text(
          'Beauty Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            tooltip: isGridView ? 'List View' : 'Grid View',

            icon: Icon(
              isGridView
                  ? Icons.view_list
                  : Icons.grid_view,
            ),

            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),

      body: products.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
              onRefresh: _refreshProducts,

              child: isGridView
                  ? _buildGridView()
                  : _buildListView(),
            ),
    );
  }
}