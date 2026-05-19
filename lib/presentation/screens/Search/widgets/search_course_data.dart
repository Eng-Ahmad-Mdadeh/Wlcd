class SearchCourseData {
  const SearchCourseData({required this.title, required this.category, required this.price, required this.rating, required this.reviews, required this.level, required this.imageUrl});
  final String title;
  final String category;
  final double price;
  final double rating;
  final String reviews;
  final String level;
  final String imageUrl;
}

const searchCourses = [
  SearchCourseData(title: 'User Experience Design Essentials: Figma UI UX Design', category: 'UX Design', price: 89, rating: 4.8, reviews: '31,882', level: 'beginner', imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800'),
  SearchCourseData(title: 'Master Digital Product Design: UX Research & UI Design', category: 'UX Design', price: 69, rating: 4.5, reviews: '765', level: 'intermediate', imageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=800'),
  SearchCourseData(title: 'UX Design for Beginners: The Essential of UX Usability', category: 'UX Design', price: 111.99, rating: 4.8, reviews: '386', level: 'beginner', imageUrl: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800'),
  SearchCourseData(title: 'The Complete Investment Banking Course', category: 'Finance', price: 89, rating: 4.8, reviews: '880', level: 'beginner', imageUrl: 'https://images.unsplash.com/photo-1556740749-887f6717d7e4?w=800'),
  SearchCourseData(title: 'Photoshop: Blend Tool to Save Your Projects', category: 'Design', price: 89, rating: 4.8, reviews: '940', level: 'intermediate', imageUrl: 'https://images.unsplash.com/photo-1581291518857-4e27b48ff24e?w=800'),
  SearchCourseData(title: 'Complete Web Design from Figma to HTML CSS', category: 'UX Design', price: 89, rating: 4.6, reviews: '520', level: 'beginner', imageUrl: 'https://images.unsplash.com/photo-1522542550221-31fd19575a2d?w=800'),
];
