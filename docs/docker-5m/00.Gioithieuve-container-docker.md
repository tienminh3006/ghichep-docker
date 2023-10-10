## Giới thiệu về container và docker

### <a name="docker-container">I. Docker giúp giải quyết vấn đề gì?</a>

Việc setup và deploy application lên một hoặc nhiều server rất vất vả từ việc phải cài đặt các công cụ, môi trường cần cho application đến việc chạy được ứng dụng chưa kể việc không đồng nhất giữa các môi trường trên nhiều server khác nhau. Chính vì lý do đó Docker được ra đời để giải quyết vấn đề này.

### <a name="docker-container">II. Docker là gì?</a>

Docker là nền tảng phần mềm cho phép bạn dựng, kiểm thử và triển khai ứng dụng một cách nhanh chóng. Docker đóng gói phần mềm vào các đơn vị tiêu chuẩn hóa được gọi là container có mọi thứ mà phần mềm cần để chạy, trong đó có thư viện, công cụ hệ thống, mã và thời gian chạy. Bằng cách sử dụng Docker, bạn có thể nhanh chóng triển khai và thay đổi quy mô ứng dụng vào bất kỳ môi trường nào và biết chắc rằng mã của bạn sẽ chạy được.

### <a name="docker-container">III. Ưu điểm của Docker</a>

- Dễ dàng sử dụng: Bình thường khi cần chạy ứng dụng chúng ta cần cài đầy đủ môi trường trên máy tính, chưa kể có sự xung đột, sự cố xảy ra với các ứng dụng. Với Docker, bạn có thể đóng gói tất cả các thành phần của ứng dụng vào một container và chạy nó trên bất kỳ máy tính nào mà không cần phải cài đặt lại môi trường.
- Linh hoạt: Triển khai ở bất kỳ nơi đâu do sự phụ thuộc của ứng dụng vào tầng OS cũng như cơ sở hạ tầng được loại bỏ.
- Môi trường chạy và khả năng mở rộng: Bạn có thể chia nhỏ những chức năng của ứng dụng thành các container riêng lẻ. Ví dụng Database chạy trên một container và Redis cache có thể chạy trên một container khác trong khi ứng dụng Node.js lại chạy trên một cái khác nữa. Với Docker, rất dễ để liên kết các container với nhau để tạo thành một ứng dụng, làm cho nó dễ dàng scale, update các thành phần độc lập với nhau.

### <a name="docker-container">IV. Các thành phần chính của Docker</a>

![docker5m-01-2.jpg](../../images/docker5m-02-1.jpg)

- Docker Engine: dùng để tạo ra Docker image và chạy Docker container. Là thành phần chính của Docker, như một công cụ để đóng gói ứng dụng.
- Docker Hub: dịch vụ lưu trữ giúp chứa các Docker image. Trên DockerHub có hàng ngàn public images được tạo bởi cộng đồng cho phép bạn dễ dàng tìm thấy những image mà bạn cần. Và chỉ cần pull về và sử dụng với một số config mà bạn mong muốn.
- Docker Image: một dạng tập hợp các tệp của ứng dụng, được tạo ra bởi Docker engine. Nội dung của các Docker image sẽ không bị thay đổi khi di chuyển. Docker image được dùng để chạy các Docker container. Bạn có thể tự build một image riêng cho mình hoặc sử dụng những image được chia sẽ từ cộng đồng Docker Hub. Một image sẽ được build dựa trên những chỉ dẫn của Dockerfile.
- Docker Container: một dạng runtime của các Docker image, dùng để làm môi trường chạy ứng dụng. Bạn có thể create, start, stop, move or delete container dựa trên Docker API hoặc Docker CLI.
- Docker Registry: là nơi lưu trữ riêng của Docker Images. Images được push vào registry và client sẽ pull images từ registry. Có thể sử dụng registry của riêng bạn hoặc registry của nhà cung cấp như : Alibaba Cloud, AWS, Google Cloud, Microsoft Azure...Docker Networking: cho phép kết nối các container lại với nhau. Kết nối này có thể trên 1 host hoặc nhiều host.
- Docker Daemon: lắng nghe các yêu cầu từ Docker Client để quản lý các đối tượng như Container, Image, Network và Volumes thông qua REST API. Các Docker Daemon cũng giao tiếp với nhau để quản lý các Docker Service.
- Docker Compose: là công cụ cho phép run app với nhiều Docker containers 1 cách dễ dàng hơn. Docker Compose cho phép bạn config các command trong file docker-compose.yml để sử dụng lại. Có sẵn khi cài Docker.
- Docker volume: Volume trong Docker được dùng để chia sẻ dữ liệu cho container.
- Docker network: Đảm nhiệm nhiệm vụ kết nối mạng giữa các container với nhau, kết nối giữa container với bên ngoài, cũng như kết nối giữa các cụm (swarm) docker containers.
