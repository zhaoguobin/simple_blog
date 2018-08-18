renderer = Redcarpet::Render::HTML.new(
  filter_html: false,
  no_images: false,
  no_links: false,
  no_styles: false,
  escape_html: false,
  safe_links_only: false,
  hard_wrap: true,
  prettify: true,
  with_toc_data: true
)
MARKDOWN = Redcarpet::Markdown.new(
  renderer,
  no_intra_emphasis: true,
  tables: true,
  fenced_code_blocks: true,
  autolink: true,
  strikethrough: true,
  lax_spacing: true,
  space_after_headers: true,
  underline: true,
  highlight: true,
  footnotes: true
)
TOC = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC)
