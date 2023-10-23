/** @type {import('next').NextConfig} */
// next.config.js
const nextConfig = {
    reactStrictMode: true,
    transpilePackages: ["milkomeda-wsc-ui-test-beta", "milkomeda-wsc"],
    swcMinify: true,
    webpack: (config) => {
      config.experiments = {
        asyncWebAssembly: true,
        topLevelAwait: true,
      };
  
      return config;
    },
  };
  
  module.exports = nextConfig;
