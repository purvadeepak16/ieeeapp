import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ieee_app/models/micro_skill_model.dart';

class MicroSkillDetailScreen extends StatefulWidget {
  final MicroSkill microSkill;

  const MicroSkillDetailScreen({
    super.key,
    required this.microSkill,
  });

  @override
  State<MicroSkillDetailScreen> createState() => _MicroSkillDetailScreenState();
}

class _MicroSkillDetailScreenState extends State<MicroSkillDetailScreen> {
  late final WebViewController _descriptionWebViewController;
  late final WebViewController _resourceWebViewController;
  late final WebViewController _learnMoreWebViewController;
  bool _isDescriptionLoading = true;
  bool _isLearnMoreLoading = true;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Initialize WebView for Learn More tab
    _learnMoreWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLearnMoreLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLearnMoreLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.microSkill.externalUrl));

    // Initialize WebView for Description
    _descriptionWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() => _isDescriptionLoading = false);
          },
        ),
      )
      ..loadHtmlString(_getDescriptionHtml());

    // Initialize WebView for Resources
    _resourceWebViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // When a link is clicked in Resources tab
            if (request.url.startsWith('http')) {
              // Load the clicked URL in Learn More tab
              _learnMoreWebViewController.loadRequest(Uri.parse(request.url));
              // Switch to Learn More tab
              Future.delayed(const Duration(milliseconds: 100), () {
                _pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(_getResourcesHtml());
  }

  String _getDescriptionHtml() {
    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            padding: 16px;
            color: #333;
            height: 100vh;
            overflow-y: auto;
          }
          h1 { font-size: 24px; font-weight: bold; margin-bottom: 16px; }
          h2 { font-size: 20px; font-weight: bold; margin: 20px 0 10px 0; }
          p { font-size: 16px; line-height: 1.5; margin-bottom: 12px; }
          ul { padding-left: 20px; }
          li { margin-bottom: 8px; font-size: 16px; line-height: 1.5; }
          .category { 
            display: inline-block; 
            background: #e3f2fd; 
            padding: 4px 12px; 
            border-radius: 16px; 
            color: #1976d2;
            margin-bottom: 16px;
          }
          .difficulty { 
            display: inline-block; 
            background: #fff3e0; 
            padding: 4px 12px; 
            border-radius: 16px; 
            color: #f57c00;
            margin-left: 8px;
          }
        </style>
      </head>
      <body>
        <div class="category">${widget.microSkill.category}</div>
        <div class="difficulty">${widget.microSkill.difficulty}</div>
        
        <h1>${widget.microSkill.title}</h1>
        
        <p><strong>Quick Overview:</strong> ${widget.microSkill.teaser}</p>
        
        <h2>Detailed Description</h2>
        <p>${widget.microSkill.fullDescription}</p>
        
        <h2>Where It's Used</h2>
        <ul>
          ${widget.microSkill.useCases.map((useCase) => '<li>$useCase</li>').join()}
        </ul>
      </body>
      </html>
    ''';
  }

  String _getResourcesHtml() {
    return '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            padding: 16px;
            color: #333;
            height: 100vh;
            overflow-y: auto;
          }
          h1 { font-size: 24px; font-weight: bold; margin-bottom: 24px; }
          .resource-card {
            background: white;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-left: 4px solid #1976d2;
          }
          .resource-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1976d2;
          }
          .resource-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 12px;
            line-height: 1.4;
          }
          .resource-type {
            display: inline-block;
            background: #e8f5e9;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            color: #2e7d32;
            margin-right: 8px;
            margin-bottom: 8px;
          }
          .no-resources {
            text-align: center;
            padding: 40px 20px;
            color: #666;
          }
        </style>
      </head>
      <body>
        <h1>Learning Resources</h1>
        ${widget.microSkill.resources.isNotEmpty ? widget.microSkill.resources.map((resource) => '''
            <div class="resource-card" onclick="window.location.href='${resource.url}'" style="cursor: pointer;">
              <div class="resource-type">${resource.type.toUpperCase()}</div>
              <div class="resource-title">${resource.title}</div>
              <div class="resource-description">${resource.description}</div>
              <div style="color: #888; font-size: 12px;">
                Click to open in Learn More tab
              </div>
            </div>
          ''').join() : '<div class="no-resources">No resources available for this skill yet.</div>'}
      </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.microSkill.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareSkill,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton(0, 'Description'),
                _buildTabButton(1, 'Resources'),
                _buildTabButton(2, 'Learn More'),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {});
              },
              children: [
                // Description Tab
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        WebViewWidget(
                            controller: _descriptionWebViewController),
                        if (_isDescriptionLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ),

                // Resources Tab - Fixed height to prevent infinite scroll
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: WebViewWidget(controller: _resourceWebViewController),
                ),

                // Learn More Tab
                Expanded(
                  child: Stack(
                    children: [
                      WebViewWidget(controller: _learnMoreWebViewController),
                      if (_isLearnMoreLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          _pageController.hasClients && _pageController.page == 2
              ? FloatingActionButton.extended(
                  onPressed: _reloadLearnMore,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh'),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                )
              : null,
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _pageController.hasClients
        ? (_pageController.page?.round() == index)
        : (index == 0);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: isSelected
                ? Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  )
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _reloadLearnMore() {
    _learnMoreWebViewController.reload();
  }

  void _shareSkill() async {
    await Share.share(
      'Check out this micro-skill: ${widget.microSkill.title}\n\n${widget.microSkill.teaser}\n\nLearn more at: ${widget.microSkill.externalUrl}',
      subject: 'IEEE Micro-Skill: ${widget.microSkill.title}',
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
