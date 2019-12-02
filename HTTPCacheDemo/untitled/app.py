from flask import Flask
from flask import request, make_response

app = Flask(__name__)

@app.route('/')
def hello_world():
    # 获取 http 头部内容
    z = request.headers
    print("z from headers: ", z)

    resp = make_response('hello111222')
    resp.status = '200'
    # 304 客户端会拿缓存
    # resp.status = '304'

    # 有cache-control 不需要设置此字典，优先级低
    # 过期时间 表示存在时间，允许客户端在这个时间之前不去检查（发请求）
    # resp.headers['Expires'] = 'Thu, 19 Sep 2019 11:18:01 GMT'

    # 多少秒后过期。该指令指定从当前请求开始，允许获取的响应被重用的最长时间（单位为秒） - 例如：max-age=60表示响应可以再缓存和重用 60 秒。
    # cache-control不会因为请求设置的值而修改响应设置，反之亦然。这里考虑到一种场景，响应头中设置了一定的缓存时间，然而请求端仍然需要获取最新结果，则将请求头的缓存设置中加上“max-age=0”，则强制服务端响应这个请求。
    resp.headers['Cache-Control'] = 'max-age=30'

    # 优先级比Etag 低
    # 标识资源的最后修改时间.
    resp.headers['Last-Modified'] = 'Thu, 19 Sep 2019 10:18:01 GMT'

    # Etag
    resp.headers['Etag'] = '1234561'

    return resp

if __name__ == '__main__':
    app.run()
