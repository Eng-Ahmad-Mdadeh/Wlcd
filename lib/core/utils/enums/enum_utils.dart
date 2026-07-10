enum PageAnimation {
  /// A lightweight direction-aware slide from the reading end edge.
  slide,

  /// A clear fade for calm flows such as splash and auth pages.
  fade,

  /// The default polished page motion: fade, slight upward slide, and scale.
  none,

  /// Direction-aware slide from the reading end edge.
  slideFromEnd,

  /// Direction-aware slide from the reading start edge.
  slideFromStart,

  /// Bottom-to-top slide that works well for detail or modal-like pages.
  slideUp,

  /// Fade with subtle scale, commonly recommended for lightweight page changes.
  fadeScale,

  /// Zoom fade for high-emphasis reveals without feeling heavy.
  zoom,

  /// Material shared-axis horizontal motion for peer-level navigation.
  sharedAxisHorizontal,

  /// Material shared-axis vertical motion for moving up or down hierarchy.
  sharedAxisVertical,

  /// Material shared-axis scale motion for parent-child navigation.
  sharedAxisScale,
}
